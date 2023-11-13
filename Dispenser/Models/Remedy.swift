//
//  Remedy.swift
//  Dispenser
//
//  Created by Wagner Duarte on 13/11/23.
//

import Foundation

class Remedy {
    
    let name: String
    let dosesFrequecy: Int
    let lastDose: Time
    let remainingDoses: Int
    let remedyNotes: String
    
    init(name: String, dosesFrequecy: Int, lastDose: Time, remainingDoses: Int, remedyNotes: String) {
        self.name = name
        self.dosesFrequecy = dosesFrequecy
        self.lastDose = lastDose
        self.remainingDoses = remainingDoses
        self.remedyNotes = remedyNotes
    }
}
