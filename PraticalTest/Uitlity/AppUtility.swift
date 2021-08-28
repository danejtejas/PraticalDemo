//
//  AppUtility.swift
//  PraticalTest
//
//  Created by admin on 28/08/21.
//

import UIKit

class AppUtility: NSObject {
    
    
    static func getJsonData() -> [PoolData]? {
        
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let poolArray =  try JSONDecoder().decode(Jsondata.self, from: data)
                return poolArray.data!
            } catch {
                print("not getting data")
            }
        }
        return nil
    }
    
    
    static func setIsLogin( value : Bool) {
        UserDefaults.standard.setValue(value, forKey: "userIsLogin")
    }
    
    static func getIsLogin() -> Bool {
        if let loing = UserDefaults.standard.value(forKey: "userIsLogin") as? Bool {
            return loing
        }
        return false
    }
    
    
    
    static func moveToHomeVC()  {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: Global.StoryborderId.homeVC) as! HomeVC
        
        if #available(iOS 13, *)  {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let delegate = windowScene?.delegate as? SceneDelegate
            let window = delegate?.window
            window?.rootViewController = UINavigationController(rootViewController: homeVC)
            window?.makeKeyAndVisible()
        }
        else {
            let window  = UIApplication.shared.windows.first
            window?.rootViewController = UINavigationController(rootViewController: homeVC)
            window?.makeKeyAndVisible()
        }
    }
    
    
    
    
    static func moveToLoginVC()  {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: Global.StoryborderId.loginVC) as! LoginVC
        
        if #available(iOS 13, *)  {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let delegate = windowScene?.delegate as? SceneDelegate
            let window = delegate?.window
            window?.rootViewController = UINavigationController(rootViewController: loginVC)
            window?.makeKeyAndVisible()
        }
        else {
            let window  = UIApplication.shared.windows.first
            window?.rootViewController = UINavigationController(rootViewController: loginVC)
            window?.makeKeyAndVisible()
        }
    }
    
    
    static func showMsg( title : String? = nil,  msg : String , vc : UIViewController)  {
        
        let alert = UIAlertController(title: title ?? "", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        vc.present(alert, animated: true)
    }
    
    
   static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
