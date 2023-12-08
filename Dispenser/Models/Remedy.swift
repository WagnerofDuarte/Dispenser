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
    var frequency: Int
    var amountPerDose: Int
    var lastDoseDate: Date //STRING NO
    var remainingDoses: Int
    var notes: String
    var tubeIdentifier: Int 
    var lastDose: String // STRING OK
    
    
    init(name: String, dosesFrequecy: Int, amountPerDose: Int, lastDose: Date, remainingDoses: Int, remedyNotes: String) {
        self.id = Int.random(in: 0..<1000)
        self.name = name
        self.frequency = dosesFrequecy
        self.amountPerDose = amountPerDose
        self.lastDoseDate = lastDose
        self.remainingDoses = remainingDoses
        self.notes = remedyNotes
        self.tubeIdentifier = Remedy.searchForTubes()
        self.lastDose = ""
        lastDoseToString()
    }
    
    private func lastDoseToString(){
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day, .month, .hour, .minute, .year], from: self.lastDoseDate)
        
        guard let day = dateComponents.day else { return }
        guard let month = dateComponents.month else { return }
        guard let hour = dateComponents.hour else { return }
        guard let minutes = dateComponents.minute else { return }
        guard let year = dateComponents.year else { return }
        
        let dayString = (day > 9) ? String(day) : "0\(String(day))"
        let monthString = (month > 9) ? String(month) : "0\(String(month))"
        let hourString = (hour > 9) ? String(hour) : "0\(String(hour))"
        let minutesString = (minutes > 9) ? String(minutes) : "0\(String(minutes))"
        let yearString = String(year)
        
        let dateString = "\(yearString)-\(monthString)-\(dayString)T\(hourString):\(minutesString):00.000Z"
        
        self.lastDose = dateString
    }
    
    func stringToLastDose(dateString: String){
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)
        guard let date = formatter.date(from: dateString) else { return }
        
        self.lastDoseDate = date
        
    }
    
    func lastDoseToStringAndIntro() -> String {
        ("Última dose ingerida ás: \(dateToString(date: self.lastDoseDate))")
    }
    
    func nextDoseToString() -> String {
        guard let nextDose = Calendar.current.date(byAdding: .hour, value: self.frequency, to: self.lastDoseDate) else { return ""}
        return ("Proxima dose: \(dateToString(date: nextDose))")
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
    /*func calculateNextDose(){
        let calendar = Calendar.current
        guard let nextDose = calendar.date(byAdding: .hour, value: self.frequency, to: self.lastDose) else { return }
        self.nextDose = nextDose
    }*/
    
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
