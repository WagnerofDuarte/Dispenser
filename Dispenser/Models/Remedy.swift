//
//  Remedy.swift
//  Dispenser
//
//  Created by Wagner Duarte on 13/11/23.
//

import Foundation

class Remedy {
    
    enum TubeIdentifier {
        case firstTube
        case secondTube
        case ThirdTube
    }
    
    var name: String
    var dosesFrequecy: Int
    var amountPerDose: Int
    var lastDose: Time
    var nextDose: Time
    var remainingDoses: Int
    var remedyNotes: String
    var tube: TubeIdentifier
    
    init(name: String, dosesFrequecy: Int, amountPerDose: Int, lastDose: Time, remainingDoses: Int, remedyNotes: String) {
        self.name = name
        self.dosesFrequecy = dosesFrequecy
        self.amountPerDose = amountPerDose
        self.lastDose = lastDose
        self.remainingDoses = remainingDoses
        self.remedyNotes = remedyNotes
        
        self.nextDose = lastDose
        self.tube = TubeIdentifier.firstTube
        
    }
    
    func lastDoseToString() -> String {
        return ("Última dose ingerida ás: \(lastDose.timeToString())")
    }
    
    func timerToNextDoseToString() -> String {
        return ("Próxima dose ás: \(nextDose.timeToString())")
    }
}
