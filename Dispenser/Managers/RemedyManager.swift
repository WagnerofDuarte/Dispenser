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
    
    class func editRemedy(data: (Remedy?, Int?)){
        guard let remedy = data.0 else { return }
        guard let index = data.1 else { return }
        remedyMock[index] = remedy
    }
    
}
