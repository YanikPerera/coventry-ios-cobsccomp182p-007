//
//  UiUserLoginViewController.swift
//  YanikPerera-cobsccomp182p-007
//
//  Created by Yanik Perera on 2/20/20.
//  Copyright © 2020 Yanik Perera. All rights reserved.
//

import UIKit
import FirebaseAuth
import LocalAuthentication

class UiUserLoginViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        let alert = AlertFunction();
        
        Auth.auth().signIn(withEmail: txtUsername.text!, password: txtPassword.text!) { (user, error) in
            if error != nil {
                
                alert.showAlert(title: "Error occured", message: "You have error with your mail and password", buttonText: "Okay")
            }
            else if user != nil {
                
                alert.showAlert(title: "Signed in successfuly", message: "You have been successfully Signed In", buttonText: "Dashboard")
                
                let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "ViewController") as!ViewController
                
                let navController = UINavigationController(rootViewController: VC1)
                
                self.present(navController, animated:true, completion: nil)
            }
        }
    }
    @IBAction func btnRecoverPassword(_ sender: UIButton) {
        let RecoverPasswordAlert = UIAlertController(title: "Forgot password?", message: "Enter email address", preferredStyle: .alert)
        RecoverPasswordAlert.addTextField { (textField) in
            textField.placeholder = "Enter email address"
        }
        RecoverPasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        RecoverPasswordAlert.addAction(UIAlertAction(title: "Reset Password", style: .default, handler: { (action) in
            let resetEmail = RecoverPasswordAlert.textFields?.first?.text
            Auth.auth().sendPasswordReset(withEmail: resetEmail!, completion: { (error) in
                if error != nil{
                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                }else {
                    let resetEmailSentAlert = UIAlertController(title: "Reset email sent successfully", message: "Check your email", preferredStyle: .alert)
                    resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetEmailSentAlert, animated: true, completion: nil)
                }
            })
        }))
        //PRESENT ALERT
        self.present(RecoverPasswordAlert, animated: true, completion: nil)
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
