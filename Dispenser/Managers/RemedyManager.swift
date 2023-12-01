//
//  RemedyManager.swift
//  Dispenser
//
//  Created by Wagner Duarte on 29/11/23.
//

import Foundation

protocol RemedyManagerDelegate: AnyObject {
    
}

class RemedyManager {
    
    class func saveRemedy(newRemedy: Remedy){
        remedyMock.append(newRemedy)
    }
    
    class func deleteRemedy(index: Int){
        _ = remedyMock.remove(at: index)
    }
    
}
