//
//  DashboardViewController.swift
//  AboCheck
//
//  Created by Jan Cortiel on 17.05.19.
//  Copyright © 2019 Cortiel_Langer_Wagner. All rights reserved.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateSC: UISegmentedControl!
    @IBOutlet weak var dateLbl: UILabel!
    
    let cellID = "expirationCell"
    
    let allAbos = AboClass.allAbos
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(DashBoardTableViewCell.self, forCellReuseIdentifier: cellID)
        
        self.tableView.tableFooterView = UIView()
        allAbos.sortAbo { (abo1, abo2) -> Bool in
            guard let daysUntil1 = abo1.getDurationTillNextPayDate() else {
                return false
            }
            
            guard let daysUntil2 = abo2.getDurationTillNextPayDate() else {
                return false
            }
    
            return daysUntil1 < daysUntil2
        }
    }
    
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expirationCell", for: indexPath) as! DashBoardTableViewCell
        
        cell.abo = allAbos.get(at: indexPath.row)
        
        
        
        return cell
    }
    
    
}
