//
//  RemedyManager.swift
//  Dispenser
//
//  Created by Wagner Duarte on 29/11/23.
//

import Foundation

protocol ManagerDelegate: AnyObject {
    
}

class Manager {
    
    class func saveRemedy(newRemedy: Remedy) {
        availableTubes.remove(at: 0)
        remedyList.append(newRemedy)
        saveDataInternalStorage()
    }
    
    class func deleteRemedy(remedy: Remedy) -> Int {
        guard let index = remedyList.firstIndex(where: {$0.id == remedy.id}) else { return -1}
        let remedyDeleted = remedyList.remove(at: index)
        availableTubes.append(remedyDeleted.tube)
        saveDataInternalStorage()
        return index
    }
    
    class func editRemedy(data: (Remedy?, Int?)){
        guard let remedy = data.0 else { return }
        guard let index = data.1 else { return }
        remedyList[index] = remedy
        saveDataInternalStorage()
    }
    
    class func fetchDataFromInternalStorage(){
        if let data = UserDefaults.standard.data(forKey: "remedyList") {
            do {
                let decoder = JSONDecoder()
                remedyList = try decoder.decode([Remedy].self, from: data)
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        
        if let tubos = UserDefaults.standard.data(forKey: "tubos") {
            do {
                let decoder = JSONDecoder()
                availableTubes = try decoder.decode([Int].self, from: tubos)
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        
    }
    
    class func saveDataInternalStorage(){
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(remedyList)
            UserDefaults.standard.set(data, forKey: "remedyList")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
        
        do {
            let encoder = JSONEncoder()
            let tubos = try encoder.encode(availableTubes)
            UserDefaults.standard.set(tubos, forKey: "tubos")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
}
