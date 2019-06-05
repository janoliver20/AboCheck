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
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dateSC: UISegmentedControl!
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var costLbl: UILabel!

    let cellID = "expirationCell"

    let allAbos = AboClass.allAbos

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.layer.borderColor = UIColor.black.cgColor
        tableView.register(DashBoardTableViewCell.self, forCellReuseIdentifier: cellID)

        tableView.tableFooterView = UIView()
        fillNextUpTableView()
        fillCostLbl()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fillNextUpTableView()
        tableView.reloadData()
    }

    func fillNextUpTableView() {
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

    func fillCostLbl() {
        var sumCosts: Double = 0.0

        for i in 0 ... allAbos.count() {
            if let costs = allAbos.get(at: i)?.costsMonthly {
                sumCosts += costs
            }
        }
        printCostLbl(costs: sumCosts)
    }

    func printCostLbl(costs: Double) {
        var finalCosts = costs
        switch dateSC.selectedSegmentIndex {
        case 1:
            finalCosts = costs * 12
        default:
            finalCosts = costs
        }

        costLbl.text = "\(String(format: "%.2f", finalCosts))€"
    }

    @IBAction func changeLbl(_ sender: UISegmentedControl) {
        fillCostLbl()
    }

    func dateLblChange() {
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allAbos.count() <= 10 {
            return allAbos.count()
        }

        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expirationCell", for: indexPath) as! DashBoardTableViewCell

        cell.abo = allAbos.get(at: indexPath.row)

        return cell
    }
}
