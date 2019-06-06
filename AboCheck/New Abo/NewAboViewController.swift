//
//  NewAboViewController.swift
//  AboCheck
//
//  Created by Benedikt Langer on 15.05.19.
//  Copyright © 2019 Cortiel_Langer_Wagner. All rights reserved.
//

import UIKit

class NewAboViewController: UIViewController {
    
    var Abo: Abo?

    @IBOutlet weak var aboname: UITextField!
    
    @IBOutlet weak var monthYearSwitch: UISegmentedControl!
    @IBOutlet weak var costs: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if monthYearSwitch.selectedSegmentIndex == 0 {
            costs.placeholder = "Costs per Month"
        }
      
    }
    

    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        switch monthYearSwitch.selectedSegmentIndex {
        case 0:
            costs.placeholder = "Costs per Month"
        default:
            costs.placeholder = "Costs per Year"
        }
    }
    @IBAction func addAbo(_ sender: UIBarButtonItem) {
        let title = aboname.text ?? "Kein Text"
       
        
        AboClass.allAbos.saveAbo(title: title)
        dismiss(animated: true)
    }
    
}


    
    

