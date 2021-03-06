//
//  AboClass.swift
//  AboCheck
//
//  Created by Jan Cortiel on 15.05.19.
//  Copyright © 2019 Cortiel_Langer_Wagner. All rights reserved.
//

import UIKit
import CoreData



class AboClass {
// A static variable to access the data from everywhere in this project.
    static let allAbos = AboClass()
    
// Array for all data, which get initialized directly at startup
    private var abos: [Abo] = [Abo]()
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private init(){}
    
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
    
    func sortAbo(by sortClosure: (Abo, Abo) -> Bool){
        abos.sort(by: sortClosure)
    }
    
    func saveAbo(title: String, note: String = "", website: URL? = nil, creationDate: Date = Date(), endDate: Date? = nil, duration: Int, costsMonthly: Double = 0.0, catagory: String = "" ) {
//
        let managedContext = appDelegate.persistentContainer.viewContext
//
        let entity = NSEntityDescription.entity(forEntityName: "Abo", in: managedContext)!
//
        let abo = NSManagedObject(entity: entity, insertInto: managedContext)
//  set Values to the keys.
        abo.setValue(title, forKey: "title")
        abo.setValue(note, forKey: "note")
        abo.setValue(website, forKey: "website")
        abo.setValue(creationDate, forKey: "creationDate")
        abo.setValue(costsMonthly, forKey: "costsMonthly")
        if endDate != nil {
            abo.setValue(endDate, forKey: "endDate")
        }
        abo.setValue(catagory, forKey: "catagory")
        
        let date = Calendar.current.date(bySetting: .day, value: duration, of: creationDate)
        abo.setValue(date, forKey: "duration")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error: \(error)")
        }
        
    }
    
    func loadAbo() {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Abo")
        
        do{
            abos = try managedContext.fetch(fetchRequest) as! [Abo]
        } catch let error as NSError {
            print("Error: \(error)")
        }
        
        abos.forEach { (abo) in
            guard let duration = abo.duration else {
                return
            }
            
            if Date() > duration {
                guard let daysUntil = abo.getDurationTillNextPayDate() else {
                    return
                }
                
                abo.duration = Calendar.current.date(bySetting: .day, value: daysUntil % Int(abo.durationInDays), of: Date())
            }
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func updateObject(object: Abo) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do{
            try managedContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    func deleteObject(object: Abo){
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do{
            managedContext.delete(object)
            try managedContext.save()
        } catch let error as NSError {
            print (error.localizedDescription)
        }
        
    }
    
    
    
    
    
}
