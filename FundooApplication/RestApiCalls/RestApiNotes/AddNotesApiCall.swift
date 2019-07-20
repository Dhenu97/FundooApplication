//
//  AddNotesApiCall.swift
//  FundooApplication
//
//  Created by BridgeLabz on 19/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation
import UIKit

class AddNotesApiCall {
    
    let url = "http://34.213.106.173/api/notes/addNotes?"
    var addNotes = [AddNotes]()

    
    func addNotesToserver(){
        
        guard let url = URL(string:  url) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(addNotes)
        print(addNotes)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let jsonData = data {
                do{
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
                    print(json)
                }
                    
                catch{
                    print(error)
                }

            }
            let response = response as! HTTPURLResponse
            print(response.statusCode)
            var httpResponse = response.statusCode
            if httpResponse == 200{
                    print("sucess receiving notes")
                }
            else{
                print("error in data")
            }
        }.resume()


    }
}
