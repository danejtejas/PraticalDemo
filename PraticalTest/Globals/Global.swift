//
//  Global.swift
//  PraticalTest
//
//  Created by admin on 28/08/21.
//

import UIKit

struct  Global {

    static let documentDicURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    static let JSONDocURL = documentDicURL.appendingPathComponent("data.json")
    
    struct  StoryborderId  {
       static let loginVC = "LoginVC"
       static let registrationVC = "RegistrationVC"
       static let homeVC = "HomeVC"
    }
    
}
