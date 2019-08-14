//
//  LoginRepository.swift
//  FundooApplication
//
//  Created by BridgeLabz on 18/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation
import UIKit

class RestApiCalls {
    
    
    func loginWithRestApi(logindict:[String:String]){
        
        print("loading.. data")
        
        guard let url = URL(string:  "http://34.213.106.173/api/user/login") else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(logindict)
        let session  = URLSession.shared
        
        session.dataTask(with: request) { (data, httpresponse, error) in
            var json = [String: AnyObject]()
            if let jsonData = data {
                do{
                    json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String : AnyObject]
                    print(json)
                }
                    
                catch{
                    print(error)
                }
            };
            let response = httpresponse as! HTTPURLResponse
            print(response.statusCode)
            print("notification Posted")
            NotificationCenter.default.post(name: NSNotification.Name("UserInfo"), object: nil, userInfo: ["response":response,"data":json])
            let httpresponse = response.statusCode
            if httpresponse == 200 {
                print("sucess")
                
            }
            
            }.resume()
    }
    
    static  func GetServerData(){
        
        print("printing server data")
        
        guard let url = URL(string:"http://34.213.106.173/api/user/") else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if error != nil
            {
                return
            }
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    
                    
                    print(convertedJsonIntoDict)
                    
                    let emailid = convertedJsonIntoDict["email"] as? String

                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
        
    }
    
    
}




