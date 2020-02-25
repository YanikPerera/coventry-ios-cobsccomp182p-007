//
//  UiTabCreateViewController.swift
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
import SwiftyJSON

class UiTabCreateViewController: UIViewController {

    @IBOutlet weak var txtEventTitle: UITextField!
    @IBOutlet weak var txtEventDiscription: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var txtSummary: UITextField!
    
    var imagePicker:UIImagePickerController!
    var ref = DatabaseReference.init()
    var avatarImageUrl: String!
    var firstname: String!
    
    var refEvents: DatabaseReference!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.ref = Database.database().reference()
        imgPicture.isUserInteractionEnabled = true

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnAddimage(_ sender: UIButton) {
       self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func btnUploadEvent(_ sender: UIButton) {
   
        let alert = AlertFunction()
        if (txtEventTitle.text == "") {
            alert.showAlert(title: "Event", message: "Title is required:",buttonText: "Add Missing Event")
            return
        }
        
        if (txtEventDiscription.text == ""){
            alert.showAlert(title: "Event", message: "Title is required:",buttonText: "Add Missing Event")
            return
        }
        if (imgPicture.image == nil){
            alert.showAlert(title: "Event", message: "Event Image is required:",buttonText: "Add Missing Event")
            return
        }
        if (txtSummary.text == nil){
            alert.showAlert(title: "Event", message: "Event Summery is required:",buttonText: "Add Missing Event")
            return
        }
        if (txtLocation.text == nil){
            alert.showAlert(title: "Event", message: "Location is required:",buttonText: "Add Missing Event")
            return
        }
        self.saveFIRData()
        //navigationController?.popViewController(animated: true)
        
        alert.showAlert(title: "Event", message: "Event Added Successfully", buttonText: "Event Home")
        
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "UiTabBarHomeViewController") as!UiTabBarHomeViewController
        
        let navController = UINavigationController(rootViewController: VC1)
        
        self.present(navController, animated:true, completion: nil)

        
}
    func saveFIRData(){
        self.uploadMedia(image: imgPicture.image!){ url in
            self.saveImage(profileImageURL: url!){ success in
                if (success != nil){
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
    }
    
    func uploadMedia(image :UIImage, completion: @escaping ((_ url: URL?) -> ())) {
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("events").child(imageName)
        let imgData = self.imgPicture.image?.pngData()
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
        //let alert = AlertFunction()
        let dict = ["description": txtEventDiscription.text!, "imageUrl": profileImageURL.absoluteString,"event_title": txtEventTitle.text!,"summery": txtSummary.text!,"location": txtLocation.text!] as [String : Any]
        self.ref.child("events").childByAutoId().setValue(dict)
        //alert.showAlert(title: "Event", message: "Event Added Successfully", buttonText: "Event Home")
        
       /* let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "UiTabBarHomeViewController") as!UiTabBarHomeViewController
        
        let navController = UINavigationController(rootViewController: VC1)
        
        self.present(navController, animated:true, completion: nil)*/
    }
    
    
}
extension UiTabCreateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imgPicture.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
