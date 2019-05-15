//
//  ListViewController.swift
//  AboCheck
//
//  Created by Niklas Wagner on 15.05.19.
//  Copyright © 2019 Cortiel_Langer_Wagner. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    let allAbos = AboClass.allAbos

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        allAbos.loadAbo()
    }
    
    

    

}
