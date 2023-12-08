//
//  NotificationManager.swift
//  Dispenser
//
//  Created by Wagner Duarte on 07/12/23.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    func askPermition(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { sucess, error in
            if sucess {
                print("Access Granted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendReminderNotification(remedy: Remedy, type: String){
        
        var content = UNMutableNotificationContent()
        var trigger: UNNotificationTrigger?
        
        if type == "scheduled-not" {
            
            guard let nextDose = Calendar.current.date(byAdding: .hour, value: remedy.frequency, to: remedy.lastDoseDate) else { return }
            
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: nextDose)
            
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            content.title = "Vamos tomar um medicamento?"
            content.body = "O remédio \(remedy.name) será disponibilizado em 5 min!"
            content.sound = UNNotificationSound.default
            
        } else if type == "time-to-ingest" {
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: Date())
            
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    
            content.title = "Suas doses estão prontas"
            content.body = "Vá para o dispenser, seus remédios estão prontos para serem tomados!"
            content.sound = UNNotificationSound.default
            
        } else if type == "insist" {
            
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: true)
    
            content.title = "Suas doses estão prontas"
            content.body = "Vá para o dispenser, seus remédios estão prontos para serem tomados!"
            content.sound = UNNotificationSound.default
        }
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
    }
}
