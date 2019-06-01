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
    
    private var datepicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datepicker = UIDatePicker()
        datepicker?.datePickerMode = .date
        datepicker?.addTarget(self, action: #selector(ExtendedOptionsController.dateChanged(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ExtendedOptionsController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        memberSince.inputView = datepicker
        
       
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer ){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        memberSince.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
        
    }

    
    
    
    @IBOutlet weak var memberSince: UITextField!
    
    
}

