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
            if !sucess {
                print("Access to Notifications Granted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendReminderNotification(remedy: Remedy, type: String){
        
        let content = UNMutableNotificationContent()
        var trigger: UNNotificationTrigger?
        guard let lastDoseDate = remedy.lastDoseDate else { return }
        guard let nextDose = Calendar.current.date(byAdding: .minute, value: remedy.frequency, to: lastDoseDate) else { return }
        
        if type == "scheduled" {

            guard let fiveBeforeNextDose = Calendar.current.date(byAdding: .minute, value: -1, to: nextDose) else { return }
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: fiveBeforeNextDose)
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            content.title = "Em breve seus medicamentos estarão prontos!"
            content.body = "O remédio \(remedy.name) será disponibilizado em 5 min!"
            content.sound = UNNotificationSound.default
            
        } else if type == "time-to-ingest" {
            
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: nextDose)
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    
            content.title = "Suas doses estão prontas!"
            content.body = "Vá para o dispenser, seus remédios estão prontos para serem tomados!"
            content.sound = UNNotificationSound.default
            
        }
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        print("Notificacao enviada")
        
    }
}
