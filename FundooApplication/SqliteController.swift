//
//  SqliteController.swift
//  FundooApplication
//
//  Created by BridgeLabz on 10/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit
import SQLite3

class SqliteController: UIViewController {
    
    var sqliteDatabase : OpaquePointer?
    
    var stmt:OpaquePointer?
    
    // var arrlist = [FunctionDatabase]()
    
    
    
    let dbFileName = "Signup.db"
    let TableName = "Users"
    let id = "id"
    let name = "name"
    let email = "email"
    let mobilenumber = "mobilenumber"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openDB()
        createDBTable()
    }
    
    func openDB(){
        let filePathUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbFileName)
        
        if sqlite3_open(filePathUrl.path , &sqliteDatabase) != SQLITE_OK {
            print("error while opening SQLite database")
        } else {
            print("database opened at \(filePathUrl.path)")
        }
    }
    
    func createDBTable(){
        if sqlite3_exec(sqliteDatabase, "CREATE TABLE IF NOT EXISTS \(TableName) (\(id) INTEGER PRIMARY KEY AUTOINCREMENT, \(name) TEXT, \(email) TEXT, \(mobilenumber) TEXT)", nil, nil, nil) != SQLITE_OK {
            print("tablecrearted")
            let errmsg = String(cString: sqlite3_errmsg(sqliteDatabase)!)
            print("error creating table: \(errmsg)")
        }
    }
    
    func insert(data : modeldata){
        let queryString = "INSERT INTO \(TableName)  ( \(name), \(email), \(mobilenumber)) VALUES ('\(data.name!)', '\(data.email!)', '\(data.mobilenumber!)')"
        if sqlite3_prepare(sqliteDatabase, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(sqliteDatabase)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            print("error in executing query")
        } else {
            print("data saved")
        }
        
        if sqlite3_finalize(stmt) != SQLITE_OK  {
            print("error in finalizing the statement pointer")
        }else { print("successfully finalized the statement")}
        
    }
}

//    func saveFromTextfield(){
//
//        if sqlite3_bind_int(stmt, 0, id, -1, nil) != SQLITE_OK{
//            let errmsg = String(cString: sqlite3_errmsg(sqliteDatabase)!)
//            print("failure binding name: \(errmsg)")
//            return
//        }
//
//        if sqlite3_bind_int(stmt, 1, (name as NSString).intValue) != SQLITE_OK{
//            let errmsg = String(cString: sqlite3_errmsg(sqliteDatabase)!)
//            print("failure binding name: \(errmsg)")
//            return
//        }
//
//        if sqlite3_bind_int(stmt, 2, (email as NSString).intValue) != SQLITE_OK{
//            let errmsg = String(cString: sqlite3_errmsg(sqliteDatabase)!)
//            print("failure binding name: \(errmsg)")
//            return
//        }
//
//        if sqlite3_bind_int(stmt, 3, (mobilenumber as NSString).intValue) != SQLITE_OK{
//            let errmsg = String(cString: sqlite3_errmsg(sqliteDatabase)!)
//            print("failure binding name: \(errmsg)")
//            return
//        }
//
//    }
//    func execute(){
//        if sqlite3_step(stmt) != SQLITE_DONE {
//            let errmsg = String(cString: sqlite3_errmsg(sqliteDatabase)!)
//            print("failure inserting hero: \(errmsg)")
//            return
//        }
//    }



