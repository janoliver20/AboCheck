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
    @IBOutlet weak var dashBoardContainer: UIView!
    
    let cellID = "expirationCell"
    
    let allAbos = AboClass.allAbos
    let allMonthlyCosts = MonthlyCostClass.allMonthlyCosts
    
    var dateToShow = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.layer.borderColor = UIColor.black.cgColor
        tableView.register(DashBoardTableViewCell.self, forCellReuseIdentifier: cellID)
        
        tableView.tableFooterView = UIView()
        fillNextUpTableView()
        fillCostLbl()
        
        addSwipGestures()
        dateLblChange(date: Date())
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
    
    func addSwipGestures(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
        swipeLeft.direction = .left
        self.dashBoardContainer.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
        swipeRight.direction = .right
        self.dashBoardContainer.addGestureRecognizer(swipeRight)
        
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            getNewDate(forward: false)
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            getNewDate(forward: true)
        }
    }
    
    func getNewDate(forward: Bool) {
        let timeStampInFuture = forward ? 1 : -1
        var newDate: Date = dateToShow
        var cost = 0.0
        if dateSC.selectedSegmentIndex == 0 {
            if let newMonth = Calendar.current.date(bySetting: .month, value: timeStampInFuture, of: dateToShow) {
                dateLblChange(date: newMonth)
                newDate = newMonth
                let (_, getCosts) = allMonthlyCosts.getCosts(dateToGet: newMonth, isItMonth: true)
                cost = getCosts
            }
        }
        else {
            if let newYear = Calendar.current.date(bySetting: .year, value: timeStampInFuture, of: dateToShow) {
                dateLblChange(date: newYear, dateIdentifier: "yyyy")
                newDate = newYear
                let (_, getCosts) = allMonthlyCosts.getCosts(dateToGet: newYear, isItMonth: false)
                cost = getCosts
            }
        }
        dateToShow = newDate
        printCostLbl(costs: cost)
    }
    
    func dateLblChange(date: Date, dateIdentifier: String = "MMMMyyyy") {
        let dateFormatter = DateFormatter()
        let timeZoneIdentifier = TimeZone.current.identifier
        if timeZoneIdentifier == "de" {
            dateFormatter.locale = Locale(identifier: "de")
        }
        else if timeZoneIdentifier == "es" {
            dateFormatter.locale = Locale(identifier: "es")
        }
        else {
            dateFormatter.locale = Locale(identifier: "en")
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(dateIdentifier)
        let dateString = dateFormatter.string(from: date)
        
        dateLbl.text = dateString
    }
    
    @objc func changeDateLblToToday() {
        dateLblChange(date: Date())
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
