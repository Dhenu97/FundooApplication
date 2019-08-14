//
//  SignOutController.swift
//  FundooApplication
//
//  Created by BridgeLabz on 07/08/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit
import KeychainAccess

class SignOutController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

    }
    
    @IBOutlet weak var ProfileImageView: UIImageView!
    
    @IBOutlet weak var emaillabel: UILabel!
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func signoutbtn(_ sender: Any) {
      var email = UserDefaultManager.retriveValue(key: "email")
        KeyChainHelper.removeValues(service: "userInfo")
        UserDefaultManager.removeValue(key: "USERLOGGEGIN")
        print("logout sucessfully")
    }
    
    
    @IBAction func imgelibrary(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ProfileImageView.contentMode = .scaleAspectFit
            ProfileImageView.image = pickedImage
//            self.performSegue(withIdentifier: "ShowEditView", sender: self)
//            let imagepath = info[UIImagePickerController.InfoKey.imageURL]
          //  saveImageToFile(fileImagePath: imagepath as! String)
        print(ProfileImageView?.image?.pngData() ?? "wrong description")
//            saveImage(imageName: (ProfileImageView?.image?.description)!)
        
        }
        dismiss(animated: true, completion: nil)
    }
    
    func saveImage(imageName: String){
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        print(imagePath)
        let image = ProfileImageView.image!
        let data = (image).pngData()
        print(data!)
        let imageFile = fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
        print(imageFile)
        AddNotesApiCall.profileUpdate(fileName : imageName, data : data!)
        
    }
   
}
    
    
    
    //    func saveImage(image : UIImage) {
//        let document = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
////        print(document!)
//        let imageUrl = document?.appendingPathComponent("myImages", isDirectory: true)
//
//        if !FileManager.default.fileExists(atPath: imageUrl!.absoluteString) {
//            do {
//                try  image.pngData()!.write(to: document!)
//                print("image added")
//            }
//            catch let error{
//                print(error.localizedDescription)
//                print("image not added")
//            }
//        }
//
////        ProfileImageView.image! = UIImage(contentsOfFile: fileImagePath)!
////        print(fileImagePath)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//
//
//        func saveImage(imageName: String){
//            let fileManager = FileManager.default
//            let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
//            let image = ProfileImageView.image!
//            let data = image.pngData()
//
//    }
//
    
    

