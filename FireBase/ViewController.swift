//
//  ViewController.swift
//  FireBase
//
//  Created by Viet Asc on 1/3/19.
//  Copyright © 2019 DangCan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let ref = Firebase(url: "https://district-ka.firebaseio.com/")
    
    lazy var save = {
        
        let ka = ["name" : "Ka", "dob" : "September 10th, 2002"]
        let hoang = ["name" : "Hoang", "dob" : "January 21st, 2003"]
        let usersRef = self.ref?.child(byAppendingPath: "Ka ♡")
        
        // Set value 1:
        let users = ["ka" : ka, "hoang" : hoang]
        usersRef?.setValue(users)
        
        // Set value 2:
        let bii = ["name" : "Bii", "dob" : "September 04th, 2002"]
        usersRef?.child(byAppendingPath: "bii")?.setValue(bii)
        
        // Update child value 1
        let biiRef = usersRef?.child(byAppendingPath: "bii")
        let biiRelationship = ["relationship" : "Be"]
        biiRef?.updateChildValues(biiRelationship)
        
        // Update child value 2
        usersRef?.updateChildValues([
            "ka/relationship" : "Hoang",
            "hoang/relationship" : "Ka"
            ])
        
        // Auto ID
        let postRef = self.ref?.child(byAppendingPath: "Ka ♡")
        let be = ["name" : "Be" , "relationship" : "Bii" , "fan" : 100000] as [String:Any]
        let beRef = postRef?.childByAutoId()
        beRef?.setValue(be)
        
        // Get auto ID
        let id = beRef?.key
        
        // Transaction
        let fanRef = Firebase(url: "https://chess-27e5c.firebaseio.com/Ka ♡/\(id!)/fan")
        fanRef?.runTransactionBlock({ (data) -> FTransactionResult? in
            if let value = data?.value as? Int {
                data?.value = value + 1
            } else {
                data?.value = 1
            }
            return FTransactionResult.success(withValue: data)
        })
        
        // 2 transactions
        fanRef?.runTransactionBlock({ (data) -> FTransactionResult? in
            if let value = data?.value as? Int {
                data?.value = value + 1
            } else {
                data?.value = 1
            }
            return FTransactionResult.success(withValue: data)
        })
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        save()
        
    }
    

}
