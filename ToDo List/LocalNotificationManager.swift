//
//  LocalNotificationManager.swift
//  ToDo List
//
//  Created by John Zulewski on 10/12/20.
//

import UIKit
import UserNotifications

struct LocalNotificationManager {
    static func authorizeLocalNotifications(viewController: UIViewController) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error)
            in
            guard error == nil else {
                print("error!")
                return
            }
            if granted {
                print("Notifcaiton Authorization Granted!")
            } else {
                print("User denied notifications")
                
                DispatchQueue.main.async {
                    viewController.oneButtonAlert(title: "User Has Not Allowed Notifcations", message: "To receive alerts for reminders, open the Settings app, select To Do List > Notifications > Allow Notifications.")
                }
                
            }
        }
    }
    
    static func isAuthorized(completed: @escaping (Bool) -> ()) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error)
            in
            guard error == nil else {
                print("error!")
                completed(false)
                return
            }
            if granted {
                print("Notifcaiton Authorization Granted!")
                completed(true)
            } else {
                print("User denied notifications")
                completed(false)
                
                
            }
        }
    }
    
    static func setCalendarNotification(title: String, subtitle: String, body: String, badgeNumber: NSNumber?, sound: UNNotificationSound?, date: Date) -> String {
        // create content:
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = sound
        content.badge = badgeNumber
        
        //create trigger
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        dateComponents.second = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //create request
        let notificationID = UUID().uuidString
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
        
        //register request with the notification center
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error! \(error.localizedDescription)")
            } else {
                print("Notification schedule \(notificationID), title: \(content.title)")
            }
        }
        return notificationID
    }
}
