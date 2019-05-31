//
//  AboExtension.swift
//  AboCheck
//
//  Created by Jan Cortiel on 31.05.19.
//  Copyright © 2019 Cortiel_Langer_Wagner. All rights reserved.
//

import UIKit
import CoreData

extension Abo {
    func getDurationTillEndDate() -> Int? {
        
        if let endDate = endDate {
            let calendar = Calendar.current
            
            let date1 = calendar.startOfDay(for: Date())
            let date2 = calendar.startOfDay(for: endDate)
            
            let components = calendar.dateComponents([.day], from: date1, to: date2)
            
            return components.day
        }
        else {
            
        }
        
        
    }
    
    
}
