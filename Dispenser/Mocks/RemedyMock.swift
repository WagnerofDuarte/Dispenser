//
//  RemedyMock.swift
//  Dispenser
//
//  Created by Wagner Duarte on 29/11/23.
//

import Foundation

var remedyMock: [Remedy] = [Remedy(name: "Navalgina",
                                   dosesFrequecy: 3,
                                   amountPerDose: 1,
                                   lastDose: Time(hour: 12, minutes: 0),
                                   remainingDoses: 8,
                                   remedyNotes: "Remédio usado para me ajudar com dores"),
                            Remedy(name: "Dipirona",
                                   dosesFrequecy: 2,
                                   amountPerDose: 2,
                                   lastDose: Time(hour: 15, minutes: 0),
                                   remainingDoses: 13,
                                   remedyNotes: "Remédio usado para me ajudar com alergia")]
