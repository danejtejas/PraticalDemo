//
//  RegistrationVC.swift
//  PraticalTest
//
//  Created by admin on 28/08/21.
//

import UIKit
import MBProgressHUD

class RegistrationVC: UIViewController {
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtFullName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func btnRegitrationClick(_ sender: UIButton) {
        
        if  !valid() {
            
            return
        }
        
        let user = User(fullName: txtFullName.text, emailId: txtEmail.text, password: txtPassword.text)
        MBProgressHUD.showAdded(to: self.view, animated: true)
       
        DatabaseHelper.shared.addUser(user: user) { [weak self] (isSuccess, error) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: (self?.view)!, animated: true)
                if error != nil {
                    
                    print("error ==> ", error?.localizedDescription as Any)
                    AppUtility.showMsg(msg: error!.localizedDescription, vc: self!)
                    
                }
                else {
                    AppUtility.setIsLogin(value: true)
                    AppUtility.dataFileCopyPast()
                    AppUtility.moveToHomeVC()
                }
            }
         
            
        }
        
    }
    
    
    @IBAction func btnGoToLoginClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
    
    func valid() -> Bool {
        
        if  (txtFullName.text?.isEmpty ?? true) {
            AppUtility.showMsg(msg: "Please Enter Full Name ", vc : self)
            return false
            
        }
        
        
        if  (txtEmail.text?.isEmpty ?? true) {
            AppUtility.showMsg(msg: "Please Enter email id ", vc : self)
            return false
            
        }
        else {
            if   !AppUtility.isValidEmail(txtEmail.text!) {
                AppUtility.showMsg(msg: "Please Enter valid email", vc: self)
                return false
            }
            
        }
        
        if  (txtPassword.text?.isEmpty ?? true){
            AppUtility.showMsg(msg: "Please password", vc: self)
            return false
        }
        
        return true
    }
    
    
}
