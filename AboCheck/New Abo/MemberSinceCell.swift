//
//  MemberSinceCell.swift
//  AboCheck
//
//  Created by Benedikt Langer on 27.05.19.
//  Copyright © 2019 Cortiel_Langer_Wagner. All rights reserved.
//

import UIKit

class MemberSinceCell: UITableViewCell {
    
    
    @IBAction func memberSince(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        self.textLabel?.text = dateFormatter.string(from: sender.date) 
    }
    
}
