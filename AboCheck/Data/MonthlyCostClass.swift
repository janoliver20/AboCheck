//
//  MonthlyCostClass.swift
//  AboCheck
//
//  Created by Jan Cortiel on 01.06.19.
//  Copyright © 2019 Cortiel_Langer_Wagner. All rights reserved.
//

import CoreData
import UIKit

class MonthlyCostClass {
    static let allMonthlyCosts = MonthlyCostClass()
    private var monthlyCosts: [MonthlyCost] = [MonthlyCost]()
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context: NSManagedObjectContext

    private init() {
        context = appDelegate.persistentContainer.viewContext
        loadMonthlyCosts()
    }

    func getCosts(dateToGet: Date, isItMonth: Bool = true) -> (MonthlyCost? ,Double) {
        var allCosts: Double = 0.0
        var entry: MonthlyCost?
        if yearExistsInDB(date: dateToGet) {
            if !isItMonth {
                monthlyCosts.forEach { allCostsOfYear in
                    if let costDate = allCostsOfYear.date, costDate.isInSameYear(date: dateToGet) {
                        allCosts += allCostsOfYear.cost
                    }
                }
            } else {
                if monthExistsInDB(date: dateToGet) {
                    monthlyCosts.forEach { allCostsOfMonth in
                        if let costDate = allCostsOfMonth.date,
                            costDate.isInSameMonth(date: dateToGet) &&
                                costDate.isInSameYear(date: dateToGet) {
                            allCosts += allCostsOfMonth.cost
                            entry = allCostsOfMonth
                        }
                    }
                }
            }
        }

        return (entry, allCosts)
    }

    func yearExistsInDB(date: Date) -> Bool {
        if monthlyCosts.contains(where: { (allCosts) -> Bool in
            if let costDate = allCosts.date,
                costDate.isInSameYear(date: date) {
                return true
            }
            return false
        }) {
            return true
        }
        return false
    }

    func monthExistsInDB(date: Date) -> Bool {
        if monthlyCosts.contains(where: { (allCosts) -> Bool in
            if let costDate = allCosts.date,
                costDate.isInSameYear(date: date) &&
                    costDate.isInSameMonth(date: date) {
                return true
            }
            return false
        }) {
            return true
        }
        return false
    }

    func saveMonthlyCosts() {
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func loadMonthlyCosts() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MonthlyCost")
        do {
            monthlyCosts = try context.fetch(fetchRequest) as! [MonthlyCost]
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func deleteObject(object: Abo) {
        do {
            context.delete(object)
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
