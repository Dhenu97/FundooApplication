//
//  LoginController.swift
//  FundooApplication
//
//  Created by BridgeLabz on 10/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit
import SQLite3
import DTGradientButton

class LoginController: UIViewController {
    
    
    
    
    var restApi = RestApiCalls()
    
    var db: OpaquePointer?
    
    var isLogin = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var emaitxtField: UITextField!
    
    
    @IBOutlet weak var passwordtxtfield: UITextField!
    
    func navigate(){
        
        guard let register = self.storyboard?.instantiateViewController(withIdentifier: "Dashboard")as? DashboardController
            else {
                return
        }
        self.navigationController?.pushViewController(register, animated: true)
    }
    
    @IBAction func loginbtn(_ sender: Any) {
        
        restApi.loginWithRestApi(email: emaitxtField.text!, password: passwordtxtfield.text!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToDashboard(notification:)), name: NSNotification.Name("UserInfo"), object: nil)
        print("observer loaded")
        
        //                if UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Dashboard") is DashboardController {
        //                    self.navigationController?.pushViewController(SideMenuController.navigate(), animated: true)
        //                    self.performSegue(withIdentifier: "<#T##String#>", sender: userDetails)
        //                }
        //                else{
        //
        //
        //           }
        
    }
    
    @IBAction func signubtn(_ sender: Any) {
        guard let noteV = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as? RegisterController else { return }
        print("page loading")
        navigationController?.pushViewController(noteV, animated: true)
    }
    
    @objc func navigateToDashboard(notification:Notification){
        
        let response = notification.userInfo!["response"]
        let data = notification.userInfo!["data"]
        print(data!)
        print(response!)
        if let dashVC = storyboard!.instantiateViewController(withIdentifier: "Dashboard") as? DashboardController {
            
            if let jsonData = data as? Data {
                do{
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
                    print(json)
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(viewController: dashVC, animated: true, completion: ({
                            
                            dashVC.userInfo = json
                            
                        }))
                    }
                }
                    
                catch{
                    print(error)
                }
            }
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


