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
    var credential: AuthCredential!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        mDatabase = Database.database().reference()
        
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
        observerKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //close view
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
     sự kiện click ok, nếu đã có kết nối internet thì thực hiện đổi mật khẩu
    */
    @IBAction func btnOk(_ sender: Any) {
        if (InternetConnection.isConnectedToNetwork()){
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
                    credential = EmailAuthProvider.credential(withEmail: user.email, password: user.password)
                    Auth.auth().currentUser?.reauthenticate(with: credential) { error in
                        if let error = error {
                            // An error happened.
                            print(error)
                        } else {
                            // User re-authenticated.
                            //change pass
                            Auth.auth().currentUser?.updatePassword(to: newPass) { (error) in
                                self.hideProgress()
                                if error == nil {
                                    //update new pass
                                    let dataUpdatePass = ["password": newPass];
                                    self.mDatabase.child("users").child(self.getUid()).updateChildValues(dataUpdatePass)
                                    // update pass for user
                                    self.user.password = newPass
                                    //show alert
                                    let alertView = UIAlertController(title: "Thông Báo", message: "Đổi mật khẩu thành công", preferredStyle: .alert)
                                    let action = UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
                                        self.dismiss(animated: true, completion: nil)
                                    })
                                    alertView.addAction(action)
                                    self.present(alertView, animated: true, completion: nil)
                                }
                                else {
                                    // print(error)
                                    self.showAlertDialog(message: "Đổi mật khẩu không thành công")
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        else {
            showAlertDialog(message: "Không có kết nối Internet")
        }
        
    }
    
    //get currentId
    func getUid() -> String {
        return (Auth.auth().currentUser?.uid)!;
    }
    
    //show alertView
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    //show progress dialog
    func showProgress() {
        loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Đang tải..."
    }
    
    //hide progress dialog
    func hideProgress() {
        loadingNotification.hide(animated: true)
    }
    
    //MARK: - Show, Hide Keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtCurrentPass.resignFirstResponder()
        txtConfirmPass.resignFirstResponder()
        txtNewPass.resignFirstResponder()
        return true
    }
    
    fileprivate func observerKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -160, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    func keyboardWillHide(sender: NSNotification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
}
