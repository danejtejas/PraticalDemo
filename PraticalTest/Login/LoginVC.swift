//
//  ViewController.swift
//  PraticalTest
//
//  Created by admin on 28/08/21.
//

import UIKit
import MBProgressHUD

class LoginVC : UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLoginClick(_ sender: Any) {
        if  !valid() {
            return 
        }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        DatabaseHelper.shared.loginUser(emailId: txtEmail.text!, password: txtPassword.text!) { [weak self] (isSucces, error) in
            
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
    
    //move to registration
    @IBAction func btnRegistrationClick(_ sender: UIButton) {
        
        let regc = self.storyboard?.instantiateViewController(withIdentifier: Global.StoryborderId.registrationVC) as! RegistrationVC
        
        navigationController?.pushViewController(regc, animated: false)
        
    }
    
    func valid() -> Bool {
       
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

