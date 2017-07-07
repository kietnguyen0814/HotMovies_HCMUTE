//
//  SignUpViewController.swift
//  HotMovies_UTE
//
//  Created by Kiet Nguyen on 5/28/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtEmailSignUp: LoginTextField!
    @IBOutlet weak var txtPassSignUp: LoginTextField!
    @IBOutlet weak var txtConfirmSignUp: LoginTextField!
    @IBOutlet weak var txtAddressSignUp: LoginTextField!
    @IBOutlet weak var txtPhoneSignUp: LoginTextField!
    @IBOutlet weak var txtFullNameSignUp: LoginTextField!
    
    var mDatabase: DatabaseReference!
    var loadingNotification: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
        observerKeyboard()
        //addDoneButtonOnKeyboard()
        // Do any additional setup after loading the view.
        mDatabase = Database.database().reference()
    }
    
    //close view
    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    /*
     Đăng ký, nếu chưa có kết nôi internet thì sẽ thông báo
     nguoc lại, nếu đã kết noi internet rồi thì tiến hành đăng nhập vào hệ thống
     */
    @IBAction func btnRegister(_ sender: Any) {
        if (InternetConnection.isConnectedToNetwork()){
            var result: Bool = true
            let email: String = txtEmailSignUp.text!
            let password: String = txtPassSignUp.text!
            let phone: String = txtPhoneSignUp.text!
            let confirmPass: String = txtConfirmSignUp.text!
            let address: String = txtAddressSignUp.text!
            let fullName: String = txtFullNameSignUp.text!
            
            if (email.isEmpty || password.isEmpty || phone.isEmpty || confirmPass.isEmpty || address.isEmpty || fullName.isEmpty){
                showAlertDialog(message: "Hãy điền đầy đủ thông tin");
                result = false
            }
            else{
                if !(Validate.isValidEmail(testStr: email)) {
                    showAlertDialog(message: "Sai định dạng Email")
                    result = false
                }
                
                if (password.characters.count < 6 || confirmPass.characters.count < 6) {
                    showAlertDialog(message: "Mật khẩu phải có ít nhất 6 kí tự");
                    result = false;
                }
                else {
                    if (password != confirmPass) {
                        showAlertDialog(message: "Mật khẩu không khớp")
                        result = false;
                    }
                }
                
                if (result) {
                    //show progress
                    self.showProgress()
                    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                        //hide progress
                        self.hideProgress()
                        if error == nil {
                            let dataUser = [
                                "uid": user?.uid,
                                "email": email,
                                "phone": phone,
                                "address": address,
                                "password": password,
                                "balance": 200000,
                                "fullName": fullName
                                ] as [String : Any]
                            self.mDatabase.child("users").child((user?.uid)!).updateChildValues(dataUser)
                            //move qua user info
//                            let srcUserInfo = self.storyboard?.instantiateViewController(withIdentifier: "userInfoId") as! UserInfoViewController
                            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                            //self.present(srcUserInfo, animated: true)
                            
                        } else {
                            if let errCode = AuthErrorCode(rawValue: error!._code) {
                                switch errCode {
                                case .invalidEmail:
                                    self.showAlertDialog(message: "Sai định dạng Email")
                                case .emailAlreadyInUse:
                                    self.showAlertDialog(message: "Email đã được sử dụng, vui lòng thử lại")
                                default:
                                    self.showAlertDialog(message: "Không thể tạo tài khoản, vui lòng thử lại")
                                }
                            }                    }
                    }
                }
                
            }
        }
        else {
            showAlertDialog(message: "Không có kết nối Internet")
        }
        
    }
    
    //show progress
    
    func showProgress() {
        loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Đang tải..."
    }
    
    //hide progress
    func hideProgress() {
        loadingNotification.hide(animated: true)
    }
    
    //show progress
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    //MARK: - Show, Hide Keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtEmailSignUp.resignFirstResponder()
        txtPassSignUp.resignFirstResponder()
        txtConfirmSignUp.resignFirstResponder()
        txtAddressSignUp.resignFirstResponder()
        txtPhoneSignUp.resignFirstResponder()
        txtFullNameSignUp.resignFirstResponder()
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
            self.view.frame = CGRect(x: 0, y: -170, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    func keyboardWillHide(sender: NSNotification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }

}

