//
//  UiUserFTIdViewController.swift
//  YanikPerera-cobsccomp182p-007
//
//  Created by Yanik Perera on 2/21/20.
//  Copyright © 2020 Yanik Perera. All rights reserved.
//

import UIKit
import FirebaseAuth
import LocalAuthentication

class UiUserFTIdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnFaceID(_ sender: UIButton) {
      /*  func checkUserIsLoggedIn(){
            if Auth.auth().currentUser?.uid == nil{
                let alert = AlertFunction()
        alert.showAlert(title: "You are not loged User please Login First ", message: "Error occured",buttonText: "Okay")

            }else{*/
            
        let alert = AlertFunction()
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Please use your Passcode"
        
        var authorizationError: NSError?
        
        let reason = "Authentication is required for you to continue"
        
        if localAuthenticationContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: &authorizationError) {
            
            _ = localAuthenticationContext.biometryType == LABiometryType.faceID ? "Face ID" : "Touch ID"
            localAuthenticationContext.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: reason) { (success, evaluationError) in
                if success {
                    
                    alert.showAlert(title: "Success", message: "Awesome!!... User authenticated successfully.",buttonText: "Okay")
                    
                    
                    let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "UiTabProfileViewController") as!UiTabProfileViewController
                    
                    let navController = UINavigationController(rootViewController: VC1)
                    
                    self.present(navController, animated:true, completion: nil)
                    
                } else {
                    alert.showAlert(title: "Error", message: "Error occured",buttonText: "Okay")
                    
                    if let errorObj = evaluationError {
                        let messageToDisplay = self.getErrorDescription(errorCode: errorObj._code)
                        
                        alert.showAlert(title: "Error", message: messageToDisplay,buttonText: "Okay")
                        
                    }
                }
            }
            
        } else {
            
            alert.showAlert(title: "Error", message: "User has not enrolled into using Biometricsd",buttonText: "Okay")
            
        }
            }//}}
        
    
    @IBAction func btnTouchID(_ sender: UIButton) {
        let alert = AlertFunction()
        let myContext = LAContext()
        let myLocalizedReasonString = "Biometric Authntication testing !! "
        
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    
                    DispatchQueue.main.async {
                        if success {
                            // User authenticated successfully, take appropriate action
                            //                            self.successLabel.text = "Awesome!!... User authenticated successfully"
                            
                            alert.showAlert(title: "Success", message: "Awesome!!... User authenticated successfully.",buttonText: "Okay")
                            let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "UiTabProfileViewController") as!UiTabProfileViewController
                            
                            let navController = UINavigationController(rootViewController: VC1)
                            
                            self.present(navController, animated:true, completion: nil)
                            
                            
                        } else {
                            // User did not authenticate successfully, look at error and take appropriate action
                            alert.showAlert(title: "Error", message: "Erro while Authenticating.",buttonText: "Okay")
                        }
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
                alert.showAlert(title: "Error", message: "Erro while Authenticating.",buttonText: "Okay")
            }
        } else {
            // Fallback on earlier versions
            
            alert.showAlert(title: "Error", message: "Erro while Authenticating.",buttonText: "Okay")
        }
    }
    func getErrorDescription(errorCode: Int) -> String {
        
        switch errorCode {
            
        case LAError.authenticationFailed.rawValue:
            return "Authentication was not successful, because user failed to provide valid credentials."
            
        case LAError.appCancel.rawValue:
            return "Authentication was canceled by application (e.g. invalidate was called while authentication was in progress)."
            
        case LAError.invalidContext.rawValue:
            return "LAContext passed to this call has been previously invalidated."
            
        case LAError.notInteractive.rawValue:
            return "Authentication failed, because it would require showing UI which has been forbidden by using interactionNotAllowed property."
            
        case LAError.passcodeNotSet.rawValue:
            return "Authentication could not start, because passcode is not set on the device."
            
        case LAError.systemCancel.rawValue:
            return "Authentication was canceled by system (e.g. another application went to foreground)."
            
        case LAError.userCancel.rawValue:
            return "Authentication was canceled by user (e.g. tapped Cancel button)."
            
        case LAError.userFallback.rawValue:
            return "Authentication was canceled, because the user tapped the fallback button (Enter Password)."
            
        default:
            return "Error code \(errorCode) not found"
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
