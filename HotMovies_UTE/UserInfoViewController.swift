//
//  UserInfoViewController.swift
//  HotMovies_UTE
//
//  Created by Kiet Nguyen on 6/1/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit
import Firebase

class UserInfoViewController: UIViewController {

    
    @IBOutlet weak var txtFullName: LoginTextField!
    
    @IBOutlet weak var txtEmail: LoginTextField!
    
    @IBOutlet weak var txtAddress: LoginTextField!
    @IBOutlet weak var txtPhone: LoginTextField!
    
    @IBOutlet weak var txtBalance: LoginTextField!
    
    var mDatabase: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mDatabase = Database.database().reference()
        
        //load user info
        if let uid = Auth.auth().currentUser?.uid {
            mDatabase.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                if let user = snapshot.value as? [String: AnyObject] {
                    self.txtFullName.text! = user["fullName"] as? String ?? ""
                    self.txtEmail.text! = user["email"] as? String ?? ""
                    self.txtAddress.text! = user["address"] as? String ?? ""
                    self.txtPhone.text! = user["phone"] as? String ?? ""
                    self.txtBalance.text! = String(user["balance"] as? Double ?? 0)
                    
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
