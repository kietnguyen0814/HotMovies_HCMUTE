//
//  UserInfoViewController.swift
//  HotMovies_UTE
//
//  Created by Kiet Nguyen on 6/1/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD

class UserInfoViewController: UIViewController {

    
    @IBOutlet weak var txtFullName: LoginTextField!
    
    @IBOutlet weak var txtEmail: LoginTextField!
    
    @IBOutlet weak var txtAddress: LoginTextField!
    @IBOutlet weak var txtPhone: LoginTextField!
    
    @IBOutlet weak var txtBalance: LoginTextField!
    
    var mDatabase: DatabaseReference!
    var loadingNotification: MBProgressHUD!
    var userToMove: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mDatabase = Database.database().reference()
        
        //load user info
        //show progress
        loadData()
    }
    
    //lấy thông tin cá nhân của người dùng và hiển thị lên view
    func loadData() {
        if (InternetConnection.isConnectedToNetwork()) {
            getUserData()
        }
        else {
            showAlertDialog(message: "Không có kết nối Internet")
        }
    }
    
    //show alertView
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Huỷ", style: .default, handler: nil)
        
        let tryAgainAction = UIAlertAction(title: "Thử lại", style: .default, handler: { (action: UIAlertAction) in
            self.loadData()
        })
        
        alertView.addAction(cancelAction)
        alertView.addAction(tryAgainAction)
        present(alertView, animated: true, completion: nil)
    }
    
    //lấy thông tin từ database
    func getUserData() {
        self.showProgress()
        if let uid = Auth.auth().currentUser?.uid {
            mDatabase.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                self.hideProgress()
                if let user = snapshot.value as? [String: AnyObject] {
                    let fullName = user["fullName"] as? String ?? ""
                    let email = user["email"] as? String ?? ""
                    let address = user["address"] as? String ?? ""
                    let phone = user["phone"] as? String ?? ""
                    let balance = String(user["balance"] as? Double ?? 0)
                    
                    self.txtFullName.text! = fullName
                    self.txtEmail.text! = email
                    self.txtAddress.text! = address
                    self.txtPhone.text! = phone
                    self.txtBalance.text! = balance
                    
                    self.userToMove = User.init(fullName: fullName, email: email, address: address, balance: Double(balance)!, password: user["password"] as? String ?? "" , phone: phone, uid: uid)
                    
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    //đăng xuất khỏi ứng dụng
    @IBAction func btnSignOut(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popViewController(animated: true)
            self.dismiss(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    //event click change pass
    @IBAction func btnChangePass(_ sender: Any) {
        let srcChangePass = self.storyboard?.instantiateViewController(withIdentifier: "changePassId") as! ChangePassViewController
        srcChangePass.user = userToMove
        self.present(srcChangePass, animated: true)
    }

    //show progress dialog
    func showProgress() {
        loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Đang tải..."
    }
    
    //ẩn progress dialog
    func hideProgress() {
        loadingNotification.hide(animated: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func btnHistory(_ sender: Any) { }
    
    @IBAction func btnCloseUserInfo(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
