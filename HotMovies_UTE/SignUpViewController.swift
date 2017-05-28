//
//  SignUpViewController.swift
//  HotMovies_UTE
//
//  Created by Kiet Nguyen on 5/28/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtEmailSignUp: LoginTextField!
    @IBOutlet weak var txtPassSignUp: LoginTextField!
    @IBOutlet weak var txtConfirmSignUp: LoginTextField!
    @IBOutlet weak var txtAddressSignUp: LoginTextField!
    @IBOutlet weak var txtPhoneSignUp: LoginTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
        observerKeyboard()
        //addDoneButtonOnKeyboard()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    /*
    //MARK - Set Done button on keyboard
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        //doneToolbar.barStyle = UIBarStyle.blackTranslucent // set style for done button bar
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(SignUpViewController.doneButtonAction))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        self.txtPhoneSignUp.inputAccessoryView = doneToolbar
        
    }
    
    //MARK: - User click on done button
    func doneButtonAction()
    {
        view.endEditing(true)
    }*/
    
    
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
