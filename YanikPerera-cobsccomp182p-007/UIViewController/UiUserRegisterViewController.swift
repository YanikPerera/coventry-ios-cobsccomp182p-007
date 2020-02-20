//
//  UiUserRegisterViewController.swift
//  YanikPerera-cobsccomp182p-007
//
//  Created by Yanik Perera on 2/20/20.
//  Copyright © 2020 Yanik Perera. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class UiUserRegisterViewController: UIViewController {

    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtContactnum: UITextField!
    @IBOutlet weak var txtDepartment: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtCpassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        let validator = ValidateFields()
        
        if(validator.usernameValid(username: (txtEmail.text ?? "")) && validator.passwordValid(password: txtPassword.text ?? "")) {
            
            let alert = AlertFunction()
            
            let firstname = txtFirstname.text!.trimmingCharacters(in:.whitespacesAndNewlines)
            let lastname = txtLastname.text!.trimmingCharacters(in:.whitespacesAndNewlines)
            let email = txtEmail.text!.trimmingCharacters(in:.whitespacesAndNewlines)
            let contact = txtContactnum.text!.trimmingCharacters(in:.whitespacesAndNewlines)
            let department = txtDepartment.text!.trimmingCharacters(in:.whitespacesAndNewlines)
            let password = txtPassword.text!.trimmingCharacters(in:.whitespacesAndNewlines)
            let cpassword = txtCpassword.text!.trimmingCharacters(in:.whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) {
                
                authResult, error in
                if ((error == nil)) {
                    
                    alert.showAlert(title: "Signed up successfully", message: "You have been successfully Signed up", buttonText: "Login Page")
                    
                } else {
                    
                    alert.showAlert(title: "Error", message: "Error occured", buttonText: "Register Page")
                }
                
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["firstname":firstname,"lastname":lastname,"email":email,"contact":contact,"department":department,"password":password,"cpassword":cpassword,"uid":authResult!.user.uid]){(error) in
                    if error != nil{
                        alert.showAlert(title: "Error", message: "Error saving user's data", buttonText: "Okay")
                        
                    }
                }
                
                // ...
            }
            
        }else{
            
            let alert = AlertFunction()
            
            alert.showAlert(title: "Error", message: "Username or password is invalid", buttonText: "Register")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
