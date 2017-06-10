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

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    /*@IBOutlet weak var imgBackground: UIImageView!
     @IBOutlet weak var btnSignIn: UIButton!*/
    @IBOutlet weak var txtEmailSignIn: LoginTextField!
    
    @IBOutlet weak var txtPassSignIn: LoginTextField!
    
    
    var loadingNotification: MBProgressHUD!
    
    var mDatabase: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mDatabase = Database.database().reference()
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
        observerKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showProgress() {
        loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Đang tải..."
    }
    
    func hideProgress() {
        loadingNotification.hide(animated: true)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
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
                        
                        //update new pass
                        let dataUpdatePass = ["password": password];
                        self.mDatabase.child("users").child(self.getUid()).updateChildValues(dataUpdatePass)
                        
                        
                        //let srcUserInfo = self.storyboard?.instantiateViewController(withIdentifier: "userInfoId") as! UserInfoViewController
                        //self.present(srcUserInfo, animated: true)
                        self.dismiss(animated: true)
                    }
                    else {
                        self.showAlertDialog(message: "Đăng nhập khong thành công")
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

