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
        
        
      
    }
    

    @IBAction func addAbo(_ sender: UIBarButtonItem) {
        let title = aboname.text ?? ""
       
        
        AboClass.allAbos.saveAbo(title: title)
        dismiss(animated: true)
    }
    
}


    
    

