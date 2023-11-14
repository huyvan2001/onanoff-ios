//
//  Time+.swift
//  DescendantsDNA
//
//  Created by Dmytro Davydenko on 22/09/2023.
//

import Foundation
enum TimeOfDay {
    case morning
    case afternoon
    case evening
    
    func getStringTime() -> String {
        switch self {
        case .morning:
            return "Good morning"
        case .afternoon:
            return "Good afternoon"
        case .evening:
            return "Good evening"
        }
    }
}

func getTimeOfDay() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH"
    
    if let currentTime = dateFormatter.date(from: dateFormatter.string(from: Date())) {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentTime)
        
        switch hour {
        case 0..<12:
            return TimeOfDay.morning.getStringTime()
        case 12..<18:
            return TimeOfDay.afternoon.getStringTime()
        default:
            return TimeOfDay.evening.getStringTime()
        }
    } else {
        return TimeOfDay.morning.getStringTime()
    }
}
