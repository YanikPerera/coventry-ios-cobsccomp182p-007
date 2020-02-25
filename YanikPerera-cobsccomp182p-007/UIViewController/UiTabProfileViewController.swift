//
//  UiTabProfileViewController.swift
//  YanikPerera-cobsccomp182p-007
//
//  Created by Yanik Perera on 2/20/20.
//  Copyright © 2020 Yanik Perera. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import SwiftyJSON

class UiTabProfileViewController: UIViewController {

    @IBOutlet weak var imgeUser: UIImageView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtContact: UITextField!
    @IBOutlet weak var txtDepartment: UITextField!
    var window: UIWindow?
    let alert = AlertFunction()
    var imagePicker:UIImagePickerController!
    var ref = DatabaseReference.init()
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.ref = Database.database().reference()
        
        imgeUser.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        self.window = UIWindow(frame: UIScreen.main.bounds)

        // Do any additional setup after loading the view.
        //let uid = Auth.auth().currentUser?.uid
        //let db = Firestore.firestore().reference()
        
    }
    

    @IBAction func changeImage(_ sender: UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnDashBoard(_ sender: UIButton) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "UiTabBarHomeViewController") as!UiTabBarHomeViewController
        
        let navController = UINavigationController(rootViewController: VC1)
        
        self.present(navController, animated:true, completion: nil)
    }
    
    @IBAction func btnDashBoardNavigate(_ sender: UIBarButtonItem) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "UiTabBarHomeViewController") as!UiTabBarHomeViewController
        
        let navController = UINavigationController(rootViewController: VC1)
        
        self.present(navController, animated:true, completion: nil)
    }
    
    @IBAction func btnUpdateUser(_ sender: UIButton) {
        
        if (txtFirstName.text == "") {
            alert.showAlert(title: "Event", message: "Title is required:",buttonText: "Add Missing Event")
            return
        }
        
        if (txtLastName.text == ""){
            alert.showAlert(title: "Event", message: "Title is required:",buttonText: "Add Missing Event")
            return
        }
        if (txtContact.text == ""){
            alert.showAlert(title: "Event", message: "Title is required:",buttonText: "Add Missing Event")
            return
        }
        if (txtDepartment.text == ""){
            alert.showAlert(title: "Event", message: "Title is required:",buttonText: "Add Missing Event")
            return
        }
        if (imgeUser.image == nil){
            alert.showAlert(title: "Event", message: "Title is required:",buttonText: "Add Missing Event")
            return
        }
        self.saveFIRData()
        navigationController?.popViewController(animated: true)
        
    }
    func saveFIRData(){
        self.uploadMedia(image: imgeUser.image!){ url in
            self.saveImage(profileImageURL: url!){ success in
                if (success != nil){
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
    }
    
    
    func uploadMedia(image :UIImage, completion: @escaping ((_ url: URL?) -> ())) {
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("users").child(imageName)
        let imgData = self.imgeUser.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
            if error == nil{
                storageRef.downloadURL(completion: { (url, error) in
                    completion(url)
                })
            }else{
                print("error in save image")
                completion(nil)
            }
        }
    }
    
    func saveImage(profileImageURL: URL , completion: @escaping ((_ url: URL?) -> ())){
        let loggedUserEmail = UserDefaults.standard.string(forKey: "LoggedUser")
        let dict = ["firstName": txtFirstName.text!,
                    "lastName": txtLastName.text!,
                    "profileimageUrl": profileImageURL.absoluteString,
                    "mobilNo": txtContact.text!,
                    "batch": txtDepartment.text!,
                    "email":loggedUserEmail!] as [String : Any]
        self.ref.child("users").childByAutoId().setValue(dict)
        alert.showAlert(title: "Event", message: "Title is required:",buttonText: "Add Missing Event")
        return
    }
        
        

    
    
    
    @IBAction func btnSignOut(_ sender: UIButton) {
         let alert = AlertFunction()
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        UserDefaults.standard.removeObject(forKey: "LoggedUser")
        UserDefaults.standard.removeObject(forKey: "LoggedIn")
        UserDefaults.standard.removeObject(forKey: "UserUID")
        UserDefaults.standard.synchronize()
        
        alert.showAlert(title: "Signed out successfully", message: "You have been successfully Log Out", buttonText: "Okay")
        
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "ViewController") as!ViewController
        let navController = UINavigationController(rootViewController: VC1)
        
         self.present(navController, animated:true, completion: nil)
    }
    
  
}

extension UiTabProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imgeUser.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
