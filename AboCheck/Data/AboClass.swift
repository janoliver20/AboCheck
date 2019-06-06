//
//  AboClass.swift
//  AboCheck
//
//  Created by Jan Cortiel on 15.05.19.
//  Copyright © 2019 Cortiel_Langer_Wagner. All rights reserved.
//

import CoreData
import UIKit

class AboClass {
    // A static variable to access the data from everywhere in this project.
    static let allAbos = AboClass()

    // Array for all data, which get initialized directly at startup
    private var abos: [Abo] = [Abo]()
    
    let allCosts = MonthlyCostClass.allMonthlyCosts

    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context: NSManagedObjectContext

    private init() {
        context = appDelegate.persistentContainer.viewContext
        loadAbo()
    }

    func getArrays() -> [Abo] {
        return abos
    }

    func get(at index: Int) -> Abo? {
        if index < abos.count && index >= 0 {
            return abos[index]
        }
        return nil
    }

    func count() -> Int {
        return abos.count
    }

    func sortAbo(by sortClosure: (Abo, Abo) -> Bool) {
        abos.sort(by: sortClosure)
    }

    func saveAbo(title: String, note: String = "", website: URL? = nil, creationDate: Date = Date(), endDate: Date? = nil, duration: Int = 30, costsMonthly: Double = 0.0, catagory: String = "") {
//
        let abo = Abo(context: context)
        //  set Values to the keys.
        abo.title = title
        abo.note = note
        abo.website = website
        abo.creationDate = creationDate
        abo.costsMonthly = costsMonthly
        if endDate != nil {
            abo.endDate = endDate
        }
        abo.category = catagory

        let durationDate = Calendar.current.date(bySetting: .day, value: duration, of: creationDate)
        abo.duration = durationDate
        abo.durationInDays = Int16(duration)

        do {
            try context.save()
            
           updateMonthlyCosts(dateToUpdate: creationDate, costs: costsMonthly)
            
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }

    func loadAbo() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Abo")

        do {
            abos = try context.fetch(fetchRequest) as! [Abo]
        } catch let error as NSError {
            print("Error: \(error)")
        }

        abos.forEach { abo in
            guard let duration = abo.duration else {
                return
            }

            if Date() > duration {
                guard let daysUntil = abo.getDurationTillNextPayDate() else {
                    return
                }
                
                let pastMonths = Int(daysUntil / Int(abo.durationInDays))
                
                
                for i in 1...pastMonths {
                    let lastMonth = Calendar.current.date(bySetting: .month, value: -i, of: Date())
                    if let lastMonth = lastMonth {
                        updateMonthlyCosts(dateToUpdate: lastMonth, costs: abo.costsMonthly)
                    }
                }
                
                
                abo.duration = Calendar.current.date(bySetting: .day, value: daysUntil % Int(abo.durationInDays), of: Date())
            }
        }

        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func updateObject(object: Abo) {
        do {
            try context.save()
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
    
    func updateMonthlyCosts(dateToUpdate: Date, costs: Double){
        if allCosts.monthExistsInDB(date: dateToUpdate){
            let (month, _) = allCosts.getCosts(dateToGet: dateToUpdate)
            guard let monthToUpdate = month else {
                return
            }
            monthToUpdate.cost += costs
        }
        else {
            let newDate = MonthlyCost(context: context)
            newDate.date = dateToUpdate
            newDate.cost = costs
        }
        
        allCosts.saveMonthlyCosts()
    }
}
