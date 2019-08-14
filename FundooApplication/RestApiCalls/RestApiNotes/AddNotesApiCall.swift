//
//  AddNotesApiCall.swift
//  FundooApplication
//
//  Created by BridgeLabz on 19/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation
import UIKit
import Security
import KeychainAccess

class AddNotesApiCall
{
    
    static let shared = AddNotesApiCall()
    
    static  func addNotesToserver(note : NoteModel){
        
        guard let url = URL(string:  baseUrl + pathVariable.addNotes.rawValue ) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let key = KeyChainHelper.getValue(service: "userInfo", key: "AcessToken")
        request.setValue(key, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(note)
        HttpConnections.httpConnection(request: request) { (data, response, error) in
            print(data!)
            print(response!)
        }
        
    }
    
    
    static func getNotesFromserver()
    {
        var noteList = [NoteModel]()
        
        guard let url:URL = URL(string: baseUrl + pathVariable.getNotes.rawValue) else {
            print("Url is Invalid")
            return
        }
        var request = URLRequest(url: url)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let key = KeyChainHelper.getValue(service: "userInfo", key: "AcessToken")
        request.setValue(key, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        HttpConnections.httpConnection(request: request) { (data, response, error) in
            
            if(error != nil) {
                print("error \(error!.localizedDescription)")
            }
            
            let noteData = data!["data"]!["data"] as! [[String : AnyObject]]
            print(noteData)
            for i in 0..<noteData.count {
                let note:NoteModel = NoteModel.init(dict: noteData[i] as [String : AnyObject])
                noteList.append(note)
            }
            
            print("AddNotesApi : the size of list is \(noteList.count)")
            NotificationCenter.default.post(name: NSNotification.Name("NoteList"), object: nil, userInfo: ["response": response!,"List": noteList])
            
        }
        
        
    }
    
    static func postUpdateNotes(dict:[String:String]){
        guard let url = URL(string:  baseUrl + pathVariable.updateNotes.rawValue) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let key = KeyChainHelper.getValue(service: "userInfo", key: "AcessToken")
        request.setValue(key, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(dict)
        HttpConnections.httpConnection(request: request) { (data, response, error) in
        }
    }
    
    static func postPinNotes(dict:[String:Bool]){
        guard let url = URL(string:  baseUrl + pathVariable.pinUnPinNotes.rawValue) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let key = KeyChainHelper.getValue(service: "userInfo", key: "AcessToken")
        
        request.setValue(key, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(dict)
        HttpConnections.httpConnection(request: request) { (data, response, error) in
            
        }
    }
    
    static func archiveNotes(dict:[String:Bool]){
        guard let url = URL(string:  baseUrl + pathVariable.archiveNotes.rawValue) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let key = KeyChainHelper.getValue(service: "userInfo", key: "AcessToken")
        
        request.setValue(key, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(dict)
        HttpConnections.httpConnection(request: request) { (data, response, error) in
            
        }
    }
    
    static func colorNotes(dict:[String:String]){
        guard let url = URL(string:  baseUrl + pathVariable.changeColorNotes.rawValue) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let key = KeyChainHelper.getValue(service: "userInfo", key: "AcessToken")
        
        request.setValue(key, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(dict)
        HttpConnections.httpConnection(request: request) { (data, response, error) in
        }
        
    }
    
    static func remainderNotes(dict:[String:String]){
        guard let url = URL(string:  baseUrl + pathVariable.reminderNotes.rawValue) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let key = KeyChainHelper.getValue(service: "userInfo", key: "AcessToken")
        
        request.setValue(key, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(dict)
        HttpConnections.httpConnection(request: request) { (data, response, error) in
            
        }
    }
    
    static func deleteNotes(dict:[String:Bool]){
        guard let url = URL(string:  baseUrl + pathVariable.trashNotes.rawValue) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let key = KeyChainHelper.getValue(service: "userInfo", key: "AcessToken")
        
        request.setValue(key, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(dict)
        HttpConnections.httpConnection(request: request) { (data, response, error) in
            
        }
    }
    
    static func profileUpdate(fileName : String, data : Data){
        guard let url = URL(string:  baseUrl + pathVariable.profileURl.rawValue) else { return }
        var request = URLRequest(url: url)
//        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let key = KeyChainHelper.getValue(service: "userInfo", key: "AcessToken")
        request.setValue(key, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
         let boundary = AddNotesApiCall.generateBoundaryString()
        let fullData = photoDataToFormData(data: data as NSData,boundary:boundary,fileName:fileName)
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue(String(fullData.length), forHTTPHeaderField: "Content-Length")

        request.httpBody = fullData as Data
        HttpConnections.httpConnection(request: request) { (data, response, error) in
            print(response!)
        }
    }
    static func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().uuidString)"
    }
   static func photoDataToFormData(data:NSData,boundary:String,fileName:String) -> NSData {
    let fullData = NSMutableData()
        
        // 1 - Boundary should start with --
        let lineOne = "--" + boundary + "\r\n"
    fullData.append(lineOne.data(
        using:         String.Encoding.utf8,
            allowLossyConversion: false)!)
        
        // 2
        let lineTwo = "Content-Disposition: form-data; name=\"image\"; filename=\"" + fileName + "\"\r\n"
        NSLog(lineTwo)
    fullData.append(lineTwo.data(
        using:         String.Encoding.utf8,
            allowLossyConversion: false)!)
        
        // 3
        let lineThree = "Content-Type: image/jpg\r\n\r\n"
    fullData.append(lineThree.data(
        using:         String.Encoding.utf8,
            allowLossyConversion: false)!)
        
        // 4
    fullData.append(data as Data)
        
        // 5
        let lineFive = "\r\n"
    fullData.append(lineFive.data(
        using:         String.Encoding.utf8,
            allowLossyConversion: false)!)
        
        // 6 - The end. Notice -- at the start and at the end
        let lineSix = "--" + boundary + "--\r\n"
    fullData.append(lineSix.data(
        using:         String.Encoding.utf8,
            allowLossyConversion: false)!)
        
        return fullData
    }
    
    
}



//func uploadImageToServerFromApp(nameOfApi : NSString, parameters : NSString, uploadedImage : UIImage, withCurrentTask :RequestType, andDelegate :AnyObject)->Void {
//    if self.isConnectedToNetwork(){
//        currentTask = withCurrentTask
//        let myRequestUrl = NSString(format: "%@%@%@",GlobalConstants.KBaseURL,nameOfApi,parameters)
//        let url = (myRequestUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
//        var request : NSMutableURLRequest = NSMutableURLRequest()
//        request = URLRequest(url: URL(string:url as String)!) as! NSMutableURLRequest
//        request.httpMethod = "POST"
//        let boundary = generateBoundaryString()
//        //define the multipart request type
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        let image_data = UIImagePNGRepresentation(uploadedImage)
//        if(image_data == nil){
//            return
//        }
//        let body = NSMutableData()
//        let fname = "image.png"
//        let mimetype = "image/png"
//        //define the data post parameter
//        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
//        body.append("Content-Disposition:form-data; name=\"image\"\r\n\r\n".data(using: String.Encoding.utf8)!)
//        body.append("hi\r\n".data(using: String.Encoding.utf8)!)
//        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
//        body.append("Content-Disposition:form-data; name=\"image\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
//        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
//        body.append(image_data!)
//        body.append("\r\n".data(using: String.Encoding.utf8)!)
//        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
//        request.httpBody = body as Data
//        let session = URLSession.shared
//        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
//            guard let data = data, error == nil else {                                                 // check for fundamental networking error
//                // print("error=\(String(describing: error))")
//                self.showAlertMessage(title: "App name", message: "Server not responding, please try later")
//                return
//            }
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//                // print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                // print("response = \(String(describing: response))")
//                self.delegate?.internetConnectionFailedIssue()
//            }else{
//                do {
//                    self.responseDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
//                    // self.Responsedata = data as NSData
//                    //self.responseDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: AnyObject] as NSDictionary;
//
//                    self.delegate?.responseReceived()
//                } catch {
//                    //print("error serializing JSON: \(error)")
//                }
//            }
//        }
//        task.resume()
//    }
//    else{
//        // print("Internet Connection not Available!")
//        self.showAlertMessage(title: "App Name", message: "No Internet Connection..")
//    }
//}
//
//func generateBoundaryString() -> String
//{
//    return "Boundary-\(NSUUID().uuidString)"
//}
