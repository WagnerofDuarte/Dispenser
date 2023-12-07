//
//  Remedy.swift
//  Dispenser
//
//  Created by Wagner Duarte on 13/11/23.
//

import Foundation

class Remedy: Codable {
    
    var id: Int
    var name: String
    var remedyNotes: String
    var dosesHoursInterval: Int
    var amountPerDose: Int
    var tube: Int
    var remainingDoses: Int
    var lastDose: Date
    var nextDose: Date
    
    init(name: String, dosesFrequecy: Int, amountPerDose: Int, lastDose: Date, remainingDoses: Int, remedyNotes: String) {
        self.id = Int.random(in: 0..<1000)
        self.name = name
        self.dosesHoursInterval = dosesFrequecy
        self.amountPerDose = amountPerDose
        self.lastDose = lastDose
        self.nextDose = lastDose
        self.remainingDoses = remainingDoses
        self.remedyNotes = remedyNotes
        self.tube = Remedy.searchForTubes()
    }
    
    func lastDoseToStringAndIntro() -> String {
        ("Última dose ingerida ás: \(dateToString(date: self.lastDose))")
    }
    
    func nextDoseToString() -> String {
        ("Proxima dose: \(dateToString(date: self.nextDose))")
    }
    
    func dateToString(date: Date) -> String {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day, .month, .hour, .minute], from: date)
        
        guard let day = dateComponents.day else { return "" }
        guard let month = dateComponents.month else { return "" }
        guard let hour = dateComponents.hour else { return "" }
        guard let minutes = dateComponents.minute else { return "" }
        
        let dayString = (day > 9) ? String(day) : "0\(String(day))"
        let monthString = (month > 9) ? String(month) : "0\(String(month))"
        let hourString = (hour > 9) ? String(hour) : "0\(String(hour))"
        let minutesString = (minutes > 9) ? String(minutes) : "0\(String(minutes))"
        
        return ("\(hourString):\(minutesString) do dia \(dayString)/\(monthString)")
    }
    
    // Chama sempre q um remédio for despejado
    // ou ultima dose for alterada
    func calculateNextDose(){
        let calendar = Calendar.current
        guard let nextDose = calendar.date(byAdding: .hour, value: self.dosesHoursInterval, to: self.lastDose) else { return }
        self.nextDose = nextDose
    }
    
    // Chama sempre q um remédio for despejado
    func updateRemainingDoses(){
        remainingDoses = remainingDoses - amountPerDose
    }
    
}

extension Remedy {
    class func searchForTubes() -> Int {
        return availableTubes[0]
    }
}
