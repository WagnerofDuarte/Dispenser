//
//  Time.swift
//  Dispenser
//
//  Created by Wagner Duarte on 13/11/23.
//

import Foundation

class Time {
    
    let hour: Int
    let minutes: Int
    
    init(hour: Int, minutes: Int) {
        self.hour = hour
        self.minutes = minutes
    }
    
    class func stringToTime(time: String) -> Time {
        let timeSplit = time.split(separator: ":")
        let newHour = Int(timeSplit[0]) ?? 0
        let newMinutes = Int(timeSplit[1]) ?? 0
        return Time(hour: newHour, minutes: newMinutes)
    }
    
    func timeToString() -> String {
        let stringHour = hour > 9 ? "\(hour)" : "0\(hour)"
        let stringMin = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        return ("\(stringHour):\(stringMin)")
    }
    
}
