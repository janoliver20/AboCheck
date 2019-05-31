//
//  ListViewController.swift
//  AboCheck
//
//  Created by Niklas Wagner on 15.05.19.
//  Copyright © 2019 Cortiel_Langer_Wagner. All rights reserved.
//

import UIKit


class ListViewController: UIViewController {
    @IBOutlet weak var ListViewController: UITableView!
    @IBOutlet weak var sortAbos: UIPickerView!
    
    let allAbos = AboClass.allAbos
    var pickerData: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = ["Item 1", "Item 2", "Item 3", "Item 4"]
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        allAbos.loadAbo()
        ListViewController.delegate = self
        ListViewController.dataSource = self
        
    }
    
   

}

extension ListViewController:  UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allAbos.count()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "aboCell", for: indexPath) as! ListTableViewCell
        cell.nameLabel?.text = "Netflix"
        cell.costsLabel.text = String(format: "%.2f", "9.99€")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
   
    
    
}


