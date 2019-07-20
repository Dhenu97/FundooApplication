//
//  RegisterController.swift
//  FundooApplication
//
//  Created by BridgeLabz on 10/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit
import SQLite3


class RegisterController: UIViewController {
    
    var stmt: OpaquePointer?

    
    var validdata = FunctionValidation()
    
    var data = SqliteController()
    
    
    @IBOutlet weak var nametxtfield: UITextField!
    
    @IBOutlet weak var emailtxtfield: UITextField!
    
    @IBOutlet weak var passwordtxtfield: UITextField!
    
    @IBOutlet weak var confirmpasswordtxtfield: UITextField!
    
    @IBOutlet weak var mobilenumbertxtfield: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

       data.openDB()
        data.createDBTable()
    }
    
    @IBAction func registerbtn(_ sender: UIButton) {
          let user = modeldata.init(id: 2, name: nametxtfield.text, email: emailtxtfield.text, mobilenumber: mobilenumbertxtfield.text)
        validation(user: user)
        data.insert(data: user)
        print(user)

        postServerData(user: user)
        self.navigationController?.popViewController(animated: true)

    }
    
    
    func validation(user : modeldata){
        
        if nametxtfield.text == "" || emailtxtfield.text == "" || passwordtxtfield.text == "" || confirmpasswordtxtfield.text == ""||mobilenumbertxtfield.text == ""
        {
            let alert = UIAlertController(title: "Information", message: "Its Mandatort to enter all the fields", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "ok" , style: .default, handler: nil )
            
            let cancel = UIAlertAction(title: "cancel" , style: .cancel, handler: nil)
            
            alert.addAction(ok)
            
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        else if (passwordtxtfield.text != confirmpasswordtxtfield.text)
        {
            let alert = UIAlertController(title: "Information", message: "Enter the correct password", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            
            let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            
            alert.addAction(ok)
            
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        else {
            
            let user1 = modeldata.init(id: 1, name: nametxtfield.text, email: emailtxtfield.text, mobilenumber: mobilenumbertxtfield.text)
            data.insert(data: user1)
            print(user1)
            
        }
    }
    
    func registerServer(users:modeldata){
        guard let url = URL(string: "http://34.213.106.173/api/user/userSignUp"
) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }
                catch{
                    print(error)
                }
            }
            
        }.resume()
    }
    

    
    func postServerData(user:modeldata){
        
        let parameters = ["firstName": nametxtfield.text! ,
                          "lastName": "d",
                          "username": nametxtfield.text!,
                          "phoneNumber":mobilenumbertxtfield.text!,
                          "role": "user",
                          "email": emailtxtfield.text!,
                          "service": "advance",
                          "createdDate": "",
                          "password" : passwordtxtfield.text!]
        
        guard let url = URL(string: "http://34.213.106.173/api/user/userSignUp") else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do{
            let encoder = JSONEncoder()
        request.httpBody = try! encoder.encode(parameters)
            let session  = URLSession.shared
            
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data{
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                    }
                    catch{
                        print(error)
                    }
                }
                
                }.resume()
            
}
}
}
