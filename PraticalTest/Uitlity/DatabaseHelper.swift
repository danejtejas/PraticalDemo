//
//  DatabaseHelper.swift
//  PraticalTest
//
//  Created by admin on 28/08/21.
//

import UIKit
import Firebase


class DatabaseHelper {
    
    static let shared = DatabaseHelper()
    

    
    public func addUser(user : User , completion : @escaping(Bool, Error?) ->Void) {
       
        Auth.auth().createUser(withEmail: user.emailId!, password: user.password!) { authResult, error in
            
            if let error = error {
                completion(false,error)
            }
            else {
                completion(true,nil)
            }
            
        }
    }
    
    
    func loginUser(emailId : String,  password : String , completion  : @escaping(Bool, Error?) ->Void) {
        
        Auth.auth().signIn(withEmail: emailId, password: password) { authResult, error in
            
            if let error = error {
                completion(false,error)
            }
            else {
                completion(true,nil)
            }
            
        }
        
    }
    
}
