//
//  ChangePassViewController.swift
//  HotMovies_UTE
//
//  Created by Cntt03 on 6/3/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD


class ChangePassViewController: UIViewController {

    @IBOutlet weak var txtCurrentPass: LoginTextField!
    
    @IBOutlet weak var txtNewPass: LoginTextField!
    
    @IBOutlet weak var txtConfirmPass: LoginTextField!
    
    var user: User! = nil
    var loadingNotification: MBProgressHUD! = nil
    var mDatabase: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        mDatabase = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnOk(_ sender: Any) {
        let currentPass: String = txtCurrentPass.text!
        let newPass: String = txtNewPass.text!
        let confirmPass: String = txtConfirmPass.text!
        
        if (currentPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
            showAlertDialog(message: "Hãy điền đầy đủ thông tin")
        }
        else {
            var result: Bool = true;
            //check length
            if (currentPass.characters.count < 6 || newPass.characters.count < 6 || confirmPass.characters.count < 6){
                result = false;
                showAlertDialog(message: "Mật khẩu phải có ít nhất 6 kí tự");
                return;
            }
            //check current pass
            if (user.password != currentPass) {
                result = false
                showAlertDialog(message: "Mật khẩu hiện tại không chính xác");
                return ;
            }
            
            if (newPass != confirmPass) {
                result = false;
                showAlertDialog(message: "Nhập lại mật khẩu không chính xác");
                return ;
            }
            
            if (result) {
                self.showProgress()
                //change pass
                Auth.auth().currentUser?.updatePassword(to: newPass) { (error) in
                    self.hideProgress()
                    if error == nil {
                        //update new pass
                        let dataUpdatePass = ["password": newPass];
                        self.mDatabase.child("users").child(self.getUid()).updateChildValues(dataUpdatePass)
                        //show alert
                        let alertView = UIAlertController(title: "Thông Báo", message: "Đổi mật khẩu thành công", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
                            self.dismiss(animated: true, completion: nil)
                        })
                        alertView.addAction(action)
                        self.present(alertView, animated: true, completion: nil)

                    }
                    else {
                        self.showAlertDialog(message: "Đổi mật khẩu không thành công")
                    }
                }
            }
        }
        
    }
    
    func getUid() -> String {
        return (Auth.auth().currentUser?.uid)!;
    }
    
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func showProgress() {
        loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Đang tải..."
    }
    
    func hideProgress() {
        loadingNotification.hide(animated: true)
    }

}
