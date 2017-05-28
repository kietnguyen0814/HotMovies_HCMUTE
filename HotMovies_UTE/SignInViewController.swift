//
//  ViewController.swift
//  HotMovies_UTE
//
//  Created by Kiet Nguyen on 5/27/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {

    /*@IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var btnSignIn: UIButton!*/
    @IBOutlet weak var txtEmailSignIn: LoginTextField!
    @IBOutlet weak var txtPassSignIn: LoginTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
        observerKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*override func viewWillAppear(_ animated: Bool) {
        imgBackground.alpha = 0.0
        btnSignIn.alpha = 0.0
    }

    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.imgBackground.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 1.0, animations: {
            self.btnSignIn.alpha = 1.0
        }, completion: nil)
    }*/
    
    
    
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

