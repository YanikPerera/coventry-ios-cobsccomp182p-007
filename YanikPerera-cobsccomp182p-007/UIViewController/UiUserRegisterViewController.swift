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
import FirebaseFirestore
import FirebaseStorage

class UiUserRegisterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtContactnum: UITextField!
    @IBOutlet weak var txtDepartment: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtCpassword: UITextField!
    @IBOutlet weak var btnRegiter: UIButton!
    
    var ImageSelect: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleElements()
        profilePictureUpload()

        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    func styleElements(){
        
        Utility.btnButtonStyles(btnRegiter)
        Utility.txtTextFieldStyles(txtFirstname)
        Utility.txtTextFieldStyles(txtLastname)
        Utility.txtTextFieldStyles(txtEmail)
        Utility.txtTextFieldStyles(txtContactnum)
        Utility.txtTextFieldStyles(txtDepartment)
        Utility.txtTextFieldStyles(txtPassword)
        Utility.txtTextFieldStyles(txtCpassword)

        
    }
    @IBAction func btnRegister(_ sender: UIButton) {
        
        let validator = ValidateFields()
        let alert = AlertFunction()
        
        if(validator.usernameValid(username: (txtEmail.text ?? ""))) {
            if(validator.passwordValid(password: (txtPassword.text ?? ""))) {
                if(validator.contactValid(contact: (txtContactnum.text ?? ""))) {
           
            
            if (txtFirstname.text == "") {
                alert.showAlert(title: "Error with Save", message: "Please Fill First Name:",buttonText: "Add Missing Field")
                return}
            if (txtLastname.text == "") {
                alert.showAlert(title: "Error with Save", message: "Please Fill Last Name:",buttonText: "Add Missing Field")
                return}
           
            if (txtDepartment.text == "") {
                alert.showAlert(title: "Error with Save", message: "Please Fill Department:",buttonText: "Add Missing Field")
                return}
            if (txtCpassword.text == "") {
                alert.showAlert(title: "Error with Save", message: "Please Fill Confirm Password:",buttonText: "Add Missing Field")
                return}
            if (txtCpassword.text != txtPassword.text ) {
                alert.showAlert(title: "Error with Save", message: "Password And Confirm Password Should Be Match",buttonText: "Fix Error")
                return}
           
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
                   let db = Firestore.firestore()
                    let storageRef = Storage.storage().reference(forURL: "gs://nibm-events-cobsccomp182p-007.appspot.com/").child("User_profile_images").child(authResult!.user.uid)
                    
                    if let imgProfileImage = self.ImageSelect, let imageData = imgProfileImage.jpegData(compressionQuality: 0.1){
                        storageRef.putData(imageData, metadata: nil, completion: { (metadata, error ) in
                            if error != nil{
                                alert.showAlert(title: "Error", message: "Image Upload Error Please Re-check", buttonText: "Okay")
                            }
                            
                        })
                    }

                   db.collection("users").addDocument(data: ["firstname":firstname,"lastname":lastname,"email":email,"contact":contact,"department":department,"password":password,"cpassword":cpassword,
                        "uid":authResult!.user.uid]){(error) in
                        if error != nil{
                            alert.showAlert(title: "Error", message: "Error saving user's data", buttonText: "Okay")
                            
                        }
                    }
                    
                    alert.showAlert(title: "Signed up successfully", message: "You have been successfully Signed up", buttonText: "Login Page")
                    
                    let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "UiUserLoginViewController") as!UiUserLoginViewController
                    
                    let navController = UINavigationController(rootViewController: VC1)
                    
                    self.present(navController, animated:true, completion: nil)
                    
                } else {
                    
                    alert.showAlert(title: "Error", message: "Error occured", buttonText: "Register Page")
                }
                

                
                // ...
                    }
                }
                
                else{
                        
                        let alert = AlertFunction()
                        
                        alert.showAlert(title: "Error", message: "Please enter 10 Digit ContactNnumber", buttonText: "Register")
                    }

                
            }
                else{
                    
                    let alert = AlertFunction()
                    
                    alert.showAlert(title: "Error", message: "Password Strength is Not Enough", buttonText: "Register")
                }
            
        }else{
            
            let alert = AlertFunction()
            
            alert.showAlert(title: "Error", message: "Please Fill Email and it should be have Regular format Ex- abc@.com: ", buttonText: "Register")
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            ImageSelect = image
            imgProfileImage.image = image
        }
        print(info)
        
        dismiss(animated: true, completion: nil)
    }
    func profilePictureUpload(){
        
        imgProfileImage.layer.cornerRadius = 10
        imgProfileImage.clipsToBounds = true
        
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(UiUserRegisterViewController.handleSelectProfileImageView))
        imgProfileImage.addGestureRecognizer(tapGuesture)
        imgProfileImage.isUserInteractionEnabled = true
    }
    @objc func handleSelectProfileImageView(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }

}

