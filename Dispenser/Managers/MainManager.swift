//
//  RemedyManager.swift
//  Dispenser
//
//  Created by Wagner Duarte on 29/11/23.
//

import Foundation

protocol ManagerDelegate: AnyObject {
    
}

class MainManager {
    
    class func testAPI(){
        
        let teste = ClientManager()
        
        Task {
            do {
                /*let result = try await teste.getRemedy(id: 10)
                print("NOME: \(result.name)")*/
                
                teste.deleteRemedy(id: 25)
                
                /*let result = try await teste.getRemedyList()
                remedyList = result
                for i in remedyList {
                    print("NOME: \(i.name)")
                    print(result.count)
                }*/

            } catch {
                print("Unespected Error")
            }
        }
    }
    
    class func saveRemedy(newRemedy: Remedy) {
        let notification = NotificationManager()
        
        notification.sendReminderNotification(remedy: newRemedy, type: "scheduled")
        notification.sendReminderNotification(remedy: newRemedy, type: "time-to-ingest")
        
        let teste = ClientManager()
        teste.postNewRemedy(remedy: newRemedy)
        
        availableTubes.remove(at: 0)
        remedyList.append(newRemedy)
        
        saveDataInternalStorage()
    }
    
    class func deleteRemedy(remedy: Remedy) -> Int {
        
        guard let index = remedyList.firstIndex(where: {$0.id == remedy.id}) else { return -1}
        let remedyDeleted = remedyList.remove(at: index)
        
        let teste = ClientManager()
        teste.deleteRemedy(id: remedy.id)
        
        availableTubes.append(remedyDeleted.tubeIdentifier)
        saveDataInternalStorage()
        return index
    }
    
    class func editRemedy(data: (Remedy?, Int?)){
        guard let remedy = data.0 else { return }
        guard let index = data.1 else { return }
        
        let notification = NotificationManager()
        notification.sendReminderNotification(remedy: remedy, type: "scheduled")
        notification.sendReminderNotification(remedy: remedy, type: "time-to-ingest")
    
        Task {
            let teste = ClientManager()
            try await teste.putRemedy(remedy: remedy)
        }
    
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
    
    class func fetchDataFromExternalDB(){
        Task {
            do {
                let client = ClientManager()
                let notification = NotificationManager()
                remedyList = try await client.getRemedyList()
                for remedio in remedyList {
                    remedio.reloadLastDoseDate()
                }
            } catch {
                print("ERROR to update remedyList")
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
