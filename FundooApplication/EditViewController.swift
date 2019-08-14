//
//  EditViewController.swift
//  FundooApplication
//
//  Created by BridgeLabz on 13/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit
import UserNotifications


class EditViewController: UIViewController {
    
    var  userInfo:[String : Any]?
    
    var reminder:[String]?
    
    var color:String = "FFFFFF"
    
    var isEditable = false
    
    var noteToEdit:NoteModel?
    
    var isDelete = false
    
    
    @IBOutlet weak var colorPin: UIBarButtonItem!
    
    @IBOutlet weak var archiveColor: UIBarButtonItem!
    
    
    @IBOutlet weak var textfeildTxt: UITextField!
    
    @IBOutlet weak var descriptionTxtFeild: UITextField!
    
    
    @IBOutlet weak var dateTextFeild: UITextField!
    
    
    var isPinned:Bool = false
    
    var isArchive:Bool = false
    
    var reuseIdentifier = "cell"
    
    var transparentView = UIView()
    
    var tableView = UITableView()
    
    var isSideMenu = false
    
    let current = Calendar.current
    
    var delete:String?
    

    
    private var datePicker:UIDatePicker?
    
    @IBOutlet weak var topMenuConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        addObserver()
        
    }
    
    
    @IBAction func addReminder(_ sender: Any) {
        requestAuthorization()
        registerNotification(date: (datePicker?.date)!)
    }
    
    func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(colorRecived(notification:)), name: NSNotification.Name("ColorData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteNotes(notification:)), name: NSNotification.Name("deleteNotes"), object: nil)
        print("loading the new list")
    }
    
    
    @objc func colorRecived(notification:Notification){
        print("applying color")
        color = notification.userInfo!["color"] as! String
        view.backgroundColor = UIColor.init(hex: color)

        if isEditable{
            if ((noteToEdit?.color.hasPrefix("#"))!) {
                view.backgroundColor = UIColor.init(hex: color)
                let startIndex = noteToEdit!.color.index((noteToEdit!.color.startIndex), offsetBy: 1)
                let cellColor = String((noteToEdit!.color[startIndex...]))
                setcolor(color: cellColor)
            }
        }
        setcolor(color: color)
        
    }
    
    @objc func deleteNotes(notification:Notification){
            let trashNotes = ["isDeleted":isDelete]
        AddNotesApiCall.deleteNotes(dict: trashNotes)
        
    }
    
    func setcolor(color:String){
        view.borderColor = UIColor.init(hex: color)
        tableView.backgroundColor = UIColor.init(hex: color)
        
    }
    
    func bindData(){
        if isEditable{
            view.backgroundColor = UIColor.init(hex: (noteToEdit?.color)!)
        } else {
            view.backgroundColor = UIColor.white
        }
        textfeildTxt.text = noteToEdit?.title ?? ""
        descriptionTxtFeild.text = noteToEdit?.description ?? ""
        
        
    }
    
    
    @IBAction func isArchive(_ sender: Any) {
        
        if isEditable{
            isArchive = !isArchive

            print(isArchive)
        }
        else{
            isArchive = !isArchive
            print(isArchive)
        }
        
    }
    
    @IBAction func isPinned(_ sender: Any) {
        isPinned = !isPinned
        if isEditable{
            if isPinned {
                colorPin.image = #imageLiteral(resourceName: "pincolor")
            } else {
                colorPin.image = #imageLiteral(resourceName: "pin")
            }
           
            print(isPinned)
        }
        else{
            if isPinned {
//                colorPin.backButtonBackgroundImage(for: .normal, barMetrics: .default)
            } else {
                colorPin.image = #imageLiteral(resourceName: "pin")
            }
            
            print(isPinned)
        }
      
      
    }
    
    
    @IBAction func slideUpBtn(_ sender: Any) {
        
        
        if isSideMenu {
            isSideMenu = false
            topMenuConstraint.constant = -128
            
        } else {
            isSideMenu = true
            topMenuConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    private func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EditViewController.viewTapped(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setUpDatePicker () {
        
        if isEditable{
            
            datePicker = UIDatePicker()
            
            datePicker?.datePickerMode = .dateAndTime
            
            dateTextFeild.inputView = datePicker
            print(datePicker!.date)
            
            datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        }
        else{
            
            datePicker = UIDatePicker()
            
            datePicker?.datePickerMode = .dateAndTime
            
            dateTextFeild.inputView = datePicker
            print(datePicker!.date)
            
            datePicker?.addTarget(self, action: #selector(EditViewController.dateChanged(datePicker:)), for: .valueChanged)
        }
        
    }
    
    @objc func dateChanged(datePicker:UIDatePicker){
        
//        let dateFormate = DateFormatter()
//        dateFormate.dateFormat =  "dd MMM yyyy HH:mm:ss zzz"
//
//        dateFormate.timeZone = TimeZone(secondsFromGMT:
//            TimeZone.current.secondsFromGMT())
//
//        dateTextFeild.text = dateFormate.string(from: datePicker.date)
//        view.endEditing(true)
//        print(dateFormate.string(from: datePicker.date))
//        print("date\(noteToEdit?.reminder)!")
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormate.timeZone = TimeZone(secondsFromGMT:
            TimeZone.current.secondsFromGMT())
        
        dateTextFeild.text = dateFormate.string(from: datePicker.date)
        view.endEditing(true)
        print(dateFormate.string(from: datePicker.date))
       // print("date\(noteToEdit?.reminder)!")
        
        //
        //        dateFormate.timeZone = TimeZone(secondsFromGMT:
        //            TimeZone.current.secondsFromGMT())
        //        dateFormate.timeZone.secondsFromGMT(for: datePicker.date)
        //        dateTextFeild.text = dateFormate.string(from: datePicker.date)
        //        view.endEditing(true)
        //        print(datePicker.date)
        //
    }
    
    
    
    @objc func viewTapped(gesture:UITapGestureRecognizer){
        view.endEditing(true)
        
    }
    
    
    let center = UNUserNotificationCenter.current()
    private func requestAuthorization() {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("permission granted")
            } else {
                print("permission not granted")
            }
            
            guard let error = error  else { return }
            print(error.localizedDescription)
        }
    }
    
    private func registerNotification(date: Date) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Do you want the system to send notification"
        content.categoryIdentifier = "alarm"
        content.sound = .default
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request) { error in
            
            guard let error = error else { return }
            print(error.localizedDescription)
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpDatePicker()

    }
    
    @IBAction func shedulereminder(_ sender: Any) {
        registerNotification(date: (datePicker?.date)!)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
        if isEditable == true{
            let note1 = ["title":textfeildTxt.text! , "description":descriptionTxtFeild.text! ,
                         "noteId":noteToEdit?.noteId]
            print(note1)
            AddNotesApiCall.postUpdateNotes(dict: note1 as! [String : String])
            
            let pinUnPinNotes = ["isPined":isPinned]
            AddNotesApiCall.postPinNotes(dict: pinUnPinNotes)
            print(pinUnPinNotes)
            
            let archiveNotes = ["isArchived":isArchive]
            AddNotesApiCall.archiveNotes(dict: archiveNotes)
            print(archiveNotes)
            
            let colorNotes = ["color":color]
            AddNotesApiCall.colorNotes(dict: colorNotes)
            print(colorNotes)
            
            let remainderNotes = ["reminder":dateTextFeild.text!]
            AddNotesApiCall.remainderNotes(dict: remainderNotes)
            print(remainderNotes)
            
            let trashNotes = ["isDeleted":isDelete]
            AddNotesApiCall.deleteNotes(dict: trashNotes)
        }
        else{
            
            let note =  NoteModel.init(title:textfeildTxt.text! , Description: descriptionTxtFeild.text!, Color: "#" + color, isPin: isPinned, Archive: isArchive , Reminder:dateTextFeild.text!,isDelete:isDelete)
            AddNotesApiCall.addNotesToserver(note : note)
        }
        
    }
    
}

