//
//  HttpConnections.swift
//  FundooApplication
//
//  Created by BridgeLabz on 28/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation
import UIKit

class HttpConnections
{
    typealias serverData = [String :[String : AnyObject]]
    static func httpConnection(request:URLRequest,completion:@escaping (serverData?, HTTPURLResponse?, Error?) -> Void){
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, apiError) in
            guard let jsonData = data else { print("error with data"); return }
            
            do {
            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! serverData
            guard  let responseData = response as? HTTPURLResponse else  {
                print("http response parsing error")
                return
                }
                completion(json, responseData, nil)
                
                if apiError != nil {
                    completion(nil, nil, apiError)
                    print(apiError!.localizedDescription)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
//    func httpUrlRequest(url:URL , httpMethod:String ){
//        guard let url = URL(string:  baseUrl + url) else { return }
//        var request = URLRequest(url: url)
//        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        request.setValue(key, forHTTPHeaderField: "Authorization")
//        request.httpMethod = "POST"
//    }
    
}

