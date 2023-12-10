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
    var frequency: Int //Horas ou minutos
    var amountPerDose: Int
    var lastDose: String
    var remainingDoses: Int
    var notes: String
    var tubeIdentifier: Int
    var lastDoseDate: Date?
    
    
    init(name: String, dosesFrequecy: Int, amountPerDose: Int, lastDose: Date, remainingDoses: Int, remedyNotes: String) {
        self.id = -1
        self.name = name
        self.frequency = dosesFrequecy*60
        self.amountPerDose = amountPerDose
        self.lastDoseDate = lastDose
        self.remainingDoses = remainingDoses
        self.notes = remedyNotes
        self.tubeIdentifier = Remedy.searchForTubes()
        self.lastDose = ""
        lastDoseToString()
    }
    
    func lastDoseToString(){
        let calendar = Calendar.current
        guard let lastDoseDate = self.lastDoseDate else { return }
        let dateComponents = calendar.dateComponents([.day, .month, .hour, .minute, .year], from: lastDoseDate)
        
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
        guard let lastDoseDate = self.lastDoseDate else { return "" }
        let text = ("\(dateToString(date: lastDoseDate))")
        return text
    }
    
    func nextDoseToString() -> String {
        guard let lastDoseDate = self.lastDoseDate else { return "" }
        guard let nextDose = Calendar.current.date(byAdding: .minute, value: self.frequency, to: lastDoseDate) else { return ""}
        return ("\(dateToString(date: nextDose))")
    }
    
    func dateToString(date: Date) -> String {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day, .month, .hour, .minute, .year], from: date)
        
        guard let day = dateComponents.day else { return "" }
        guard let month = dateComponents.month else { return "" }
        guard var hour = dateComponents.hour else { return "" }
        hour = hour + 3
        guard let minutes = dateComponents.minute else { return "" }
        
        let dayString = (day > 9) ? String(day) : "0\(String(day))"
        let monthString = (month > 9) ? String(month) : "0\(String(month))"
        let hourString = (hour > 9) ? String(hour) : "0\(String(hour))"
        let minutesString = (minutes > 9) ? String(minutes) : "0\(String(minutes))"
        
        return ("\(hourString):\(minutesString) do dia \(dayString)/\(monthString)")
    }

    func reloadLastDoseDate(){
        
        let dateFormatter = DateFormatter()

        // Definir o formato para ISO8601 com milissegundos
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        // Converter a string para um objeto Date
        if let date = dateFormatter.date(from: self.lastDose) {
            self.lastDoseDate = date
            print("Data convertida:", date)
        } else {
            print("Não foi possível converter a string para Date")
        }
    }
}

extension Remedy {
    class func searchForTubes() -> Int {
        return availableTubes[0]
    }
}
