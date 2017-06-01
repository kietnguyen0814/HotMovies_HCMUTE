//
//  SignUpViewController.swift
//  HotMovies_UTE
//
//  Created by Kiet Nguyen on 5/28/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtEmailSignUp: LoginTextField!
    @IBOutlet weak var txtPassSignUp: LoginTextField!
    @IBOutlet weak var txtConfirmSignUp: LoginTextField!
    @IBOutlet weak var txtAddressSignUp: LoginTextField!
    @IBOutlet weak var txtPhoneSignUp: LoginTextField!
    @IBOutlet weak var txtFullNameSignUp: LoginTextField!
    
    var mDatabase: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
        observerKeyboard()
        //addDoneButtonOnKeyboard()
        // Do any additional setup after loading the view.
        mDatabase = Database.database().reference()
    }
    
    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func btnRegister(_ sender: Any) {
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
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    if error == nil {
                        let dataUser = [
                            "uid": user?.uid,
                            "email": email,
                            "phone": phone,
                            "address": address,
                            "password": password,
                            "balance": 200000,
                            "fullname": fullName
                        ] as [String : Any]
                        self.mDatabase.child("users").child((user?.uid)!).updateChildValues(dataUser)
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
            self.view.frame = CGRect(x: 0, y: -100, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    func keyboardWillHide(sender: NSNotification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }

}

