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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(DashBoardTableViewCell.self, forCellReuseIdentifier: cellID)
        
        self.tableView.tableFooterView = UIView()
    }
    
    
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expirationCell", for: indexPath) as! DashBoardTableViewCell
        
        
        return cell
    }
    
    
}
