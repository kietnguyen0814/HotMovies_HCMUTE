//
//  ViewController.swift
//  HotMovies_UTE
//
//  Created by Kiet Nguyen on 5/27/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD
import KeychainAccess

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    /*@IBOutlet weak var imgBackground: UIImageView!
     @IBOutlet weak var btnSignIn: UIButton!*/
    @IBOutlet weak var txtEmailSignIn: LoginTextField!
    
    @IBOutlet weak var chkRemember: DesignButton!
    @IBOutlet weak var txtPassSignIn: LoginTextField!
    
    
    var loadingNotification: MBProgressHUD!
    var checkbox = UIImage(named: "check")
    var unCheck = UIImage(named: "uncheck")
    var isCheck: Bool = false
    var keychain: Keychain!
    var mDatabase: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mDatabase = Database.database().reference()
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
        observerKeyboard()
        getDataFromKeyChain()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    //get data from keychain
    func getDataFromKeyChain() {
        keychain = Keychain()
        let keys = keychain.allKeys()
        for key in keys {
            let password = try! keychain.get(key)
            if (password != nil){
                txtPassSignIn.text = password
                txtEmailSignIn.text = key
                chkRemember.setImage(checkbox, for: UIControlState.normal)
                isCheck = true
            }
        }
    }
    
    /*
     kiểm tra kết nối internet trước khi thực hiện
     nếu đã có kết nối thì thực hiện đăng nhập, nếu không thì xuất ra thông báo
     */
    @IBAction func btnLogin(_ sender: Any) {
        if (InternetConnection.isConnectedToNetwork()) {
            let email: String = txtEmailSignIn.text!
            let password: String = txtPassSignIn.text!
            
            if (email.isEmpty || password.isEmpty) {
                showAlertDialog(message: "Hãy điền đầy đủ thông tin");
            }
            else {
                if !(Validate.isValidEmail(testStr: email)) {
                    self.showAlertDialog(message: "Sai định dạng Email")
                }
                else {
                    //show progress
                    self.showProgress()
                    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                        //hide progress
                        self.hideProgress()
                        if (error == nil) {
                            //save password
                            if (self.isCheck){
                                do {
                                    //remove all keychain
                                    try self.keychain.removeAll()
                                    try self.keychain.set(password, key: email)
                                }
                                catch let errorKeyChain {
                                    print(errorKeyChain)
                                }
                            }
                            else {
                                do {
                                    try self.keychain.removeAll()
                                }
                                catch let errorKeyChain {
                                    print(errorKeyChain)
                                }
                            }
                            //update new pass
                            let dataUpdatePass = ["password": password];
                            self.mDatabase.child("users").child(self.getUid()).updateChildValues(dataUpdatePass)
                            
                            //close view
                            self.dismiss(animated: true)
                        }
                        else {
                            self.showAlertDialog(message: "Đăng nhập không thành công")
                        }
                    }
                }
            }
        }
        else {
            showAlertDialog(message: "Không có kết nối Internet")
        }
    }
    
    //event click checkbox
    @IBAction func chkRememberClick(_ sender: Any) {
        if (isCheck){
            chkRemember.setImage(unCheck, for: UIControlState.normal)
            isCheck = false
        }
        else {
            chkRemember.setImage(checkbox, for: UIControlState.normal)
            isCheck = true
        }
    }
    //lấy uid mặc định của user
    func getUid() -> String {
        return (Auth.auth().currentUser?.uid)!;
    }
    
    //xuất ra thông báo sử dụng alertView
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    //close view
    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Show, Hide Keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if txtEmailSignIn.isEditing {
            txtPassSignIn.becomeFirstResponder()
        } else {
            txtPassSignIn.resignFirstResponder()
        }
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
            self.view.frame = CGRect(x: 0, y: -70, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    func keyboardWillHide(sender: NSNotification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    
}

