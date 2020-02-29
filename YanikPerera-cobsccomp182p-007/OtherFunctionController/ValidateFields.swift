//
//  ValidateFields.swift
//  YanikPerera-cobsccomp182p-007
//
//  Created by Yanik Perera on 2/20/20.
//  Copyright © 2020 Yanik Perera. All rights reserved.
//

import Foundation
class ValidateFields {
    
    func usernameValid(username : String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: username)
       // return username.count > 5
    }
    func passwordValid(password:String) -> Bool {
       /* let RegEx = "\\w{7,18}"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: password) */
        return password.count > 8
    }
    func contactValid(contact : String) -> Bool {
       /* let contactRegEx = "^7|0|(?:\+94)[0-9]{9,10}";
        let contactPred = NSPredicate(format:"SELF MATCHES %@", contactRegEx)
        return contactPred.evaluate(with: username)*/
         return contact.count == 10
    }
    func isValidEmail(txtEmail: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: txtEmail)
    }
    
}
