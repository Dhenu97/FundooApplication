//
//  LoginController.swift
//  FundooApplication
//
//  Created by BridgeLabz on 10/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit
import SQLite3

class LoginController: UIViewController {
    
    var listOfNotes = [NoteModel]()

    var restApi = RestApiCalls()
    
    var db: OpaquePointer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googlebtn.setImage(#imageLiteral(resourceName: "google"), for: .normal)
        let dictValue = UserDefaultManager.retriveValue(key: "ISUSERLOGGEDIN") as! Bool
        if dictValue{
             userVerification()
        }
    }
    
    @IBOutlet weak var googlebtn: UIButton!
    
    
    @IBOutlet weak var emaitxtField: UITextField!
    
    
    @IBOutlet weak var passwordtxtfield: UITextField!
    
    
    @IBAction func loginbtn(_ sender: Any) {
        UserDefaultManager.setValue(value: true , key: "ISUSERLOGGEDIN")
        let logindict = ["email":emaitxtField.text! , "password":passwordtxtfield.text!]
        restApi.loginWithRestApi(logindict: logindict)
        UserDefaultManager.setValue(value: logindict , key: "USERLOGGEGIN")
        NotificationCenter.default.addObserver(self, selector: #selector(parsingDataFromResponse(notification:)), name: NSNotification.Name("UserInfo"), object: nil)
        print("observer loaded")
        
    }
    
        func userVerification(){
            restApi.loginWithRestApi(logindict: UserDefaultManager.retriveValue(key: "USERLOGGEGIN") as! [String : String])
            
            if storyboard!.instantiateViewController(withIdentifier: "Dashboard") is DashboardController {
            NotificationCenter.default.addObserver(self, selector: #selector(parsingDataFromResponse(notification:)), name: NSNotification.Name("UserInfo"), object: nil)
            print("navigate to dashboard")
        
        }
        }
    
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let dismissAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(dismissAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
  
    @IBAction func signubtn(_ sender: Any) {
        guard let noteV = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as? RegisterController else { return }
        print("page loading")
        navigationController?.pushViewController(noteV, animated: true)
    }
    
    @objc func parsingDataFromResponse(notification:Notification){
        
        let response = notification.userInfo!["response"]
        let data = notification.userInfo!["data"] as! [String : AnyObject]
        print("print\(data)")
        print(response!)
        KeyChainHelper.setValue(service: "userInfo", value: data["id"] as! String , key: "AcessToken")
        _ = storyboard!.instantiateViewController(withIdentifier: "Dashboard") as? DashboardController
                  
                    DispatchQueue.main.async {
                        
    guard let dashVC = self.storyboard?.instantiateViewController(withIdentifier: "Dashboard") as? DashboardController else { return }
        print("page loading")
        self.navigationController?.pushViewController(dashVC, animated: true)
                            
                        }
                    }
    
}
extension UINavigationController
{
    public func pushViewController(viewController: UIViewController,
                                   animated: Bool,
                                   completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}


