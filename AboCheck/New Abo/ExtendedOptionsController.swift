//
//  ExtendedOptions.swift
//  AboCheck
//
//  Created by Benedikt Langer on 26.05.19.
//  Copyright © 2019 Cortiel_Langer_Wagner. All rights reserved.
//

import UIKit
import CoreData

class ExtendedOptionsController: UITableViewController{
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBOutlet weak var endDate: UITextField!
    
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(ExtendedOptionsController.dateChanged(datePicker:)), for: .valueChanged)
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ExtendedOptionsController.viewTapped))
        picker.addGestureRecognizer(tapGesture)
        
        return picker
    }()
   
    
    @IBAction func memberSinceField(_ sender: UITextField) {
        
        sender.inputView = datePicker
    }
    @IBAction func endDate(_ sender: UITextField) {
        sender.inputView = datePicker
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

//        memberSince.inputView = datePicker
//        inputView?.backgroundColor  = UIColor.white
//        endDate.inputView = datePicker
//        
//        inputView?.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 150, paddingRight: 0, width: 0, height: 0, enableInsets: false)
       
     
    }
    
    @objc func viewTapped(){
        view.endEditing(true)
    }
    
    
    @objc func dateChanged(datePicker: UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        if memberSince.isFirstResponder{
            memberSince.text = dateFormatter.string(from: datePicker.date)
            
        }
        else if endDate.isFirstResponder {
            endDate.text = dateFormatter.string(from: datePicker.date)
        }
        
        
        
        
    }
    
    
    
    @IBOutlet weak var memberSince: UITextField!
    
    
}

