//
//  AboExtension.swift
//  AboCheck
//
//  Created by Jan Cortiel on 31.05.19.
//  Copyright © 2019 Cortiel_Langer_Wagner. All rights reserved.
//

import CoreData
import UIKit

extension Abo {
    func getDurationTillNextPayDate(from: Date = Date()) -> Int? {
        let calendar = Calendar.current

        let date1 = calendar.startOfDay(for: from)

        var date2: Date?

        if let endDate = endDate {
            date2 = calendar.startOfDay(for: endDate)
        } else {
            guard let duration = duration else {
                return nil
            }

            date2 = calendar.startOfDay(for: duration)
        }
        if let date2 = date2 {
            let components = calendar.dateComponents([.day], from: date1, to: date2)
            return components.day
        }

        return nil
    }
}
