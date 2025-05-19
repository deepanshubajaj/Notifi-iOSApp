//
//  NotificationManager.swift
//  Notifi
//
//  Created by Deepanshu Bajaj on 19/05/25.
//

import UIKit
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Hello!"
        content.body = "This is a test local notification."
        content.sound = UNNotificationSound(named: UNNotificationSoundName("audioFg.wav"))
        
        // Add custom data with image name
        content.userInfo = [
            "type": "scheduled",
            "imageName": "bfgImageNotif"
        ]
        print("Scheduling notification with userInfo: \(content.userInfo)")
        
        // Set the category for expandable notification
        content.categoryIdentifier = "EXPANDABLE_CATEGORY"
        
        // Add image attachment
        if let image = UIImage(named: "bfgImageNotif"),
           let imageData = image.jpegData(compressionQuality: 0.8) {
            let tempDir = FileManager.default.temporaryDirectory
            let imageURL = tempDir.appendingPathComponent("bfgImageNotif.jpg")
            
            do {
                try imageData.write(to: imageURL)
                let attachment = try UNNotificationAttachment(
                    identifier: "scheduledImage",
                    url: imageURL,
                    options: [UNNotificationAttachmentOptionsTypeHintKey: "public.jpeg"]
                )
                content.attachments = [attachment]
                print("Successfully added image attachment")
            } catch {
                print("Error creating notification attachment: \(error)")
            }
        } else {
            print("Failed to create image data for bfgImageNotif")
        }

        // Trigger after 1 second
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: "TestNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    func simulateBackground(completion: @escaping () -> Void) {
        // Clear only delivered notifications and badge count
        DispatchQueue.main.async {
            UIApplication.shared.applicationIconBadgeNumber = 0
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            print("Cleared delivered notifications and badge count")
        }
        
        // Schedule a notification that will be delivered when the app is in background
        let content = UNMutableNotificationContent()
        content.title = "Background Notification"
        content.body = "This notification was scheduled while the app was active"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("audioBg.wav"))
        content.badge = 1  // Add badge count
        
        // Add custom data with image name
        content.userInfo = [
            "type": "background",
            "imageName": "bgImageNotif"
        ]
        print("Scheduling background notification with userInfo: \(content.userInfo)")
        
        // Set the category for expandable notification
        content.categoryIdentifier = "EXPANDABLE_CATEGORY"
        
        // Add image attachment
        if let image = UIImage(named: "bgImageNotif"),
           let imageData = image.jpegData(compressionQuality: 0.8) {
            let tempDir = FileManager.default.temporaryDirectory
            let imageURL = tempDir.appendingPathComponent("bgImageNotif.jpg")
            
            do {
                try imageData.write(to: imageURL)
                let attachment = try UNNotificationAttachment(
                    identifier: "backgroundImage",
                    url: imageURL,
                    options: [UNNotificationAttachmentOptionsTypeHintKey: "public.jpeg"]
                )
                content.attachments = [attachment]
                print("Successfully added background image attachment")
            } catch {
                print("Error creating notification attachment: \(error)")
            }
        } else {
            print("Failed to create image data for bgImageNotif")
        }

        // Trigger after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: "BackgroundNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling background notification: \(error)")
            } else {
                print("Background notification scheduled successfully")
                completion()
            }
        }
    }
    
    // Helper method to clear badge
    private func clearBadge() {
        DispatchQueue.main.async {
            // Clear badge count
            UIApplication.shared.applicationIconBadgeNumber = 0
            
            // Remove all delivered notifications
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            
            print("Cleared badge count and delivered notifications")
        }
    }
    
    func scheduleSimpleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Simple Notification"
        content.body = "This is a simple notification without any extras"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(
            identifier: "SimpleNotification",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling simple notification: \(error)")
            } else {
                print("Simple notification scheduled")
            }
        }
    }
    
    func scheduleNotificationWithSound(soundName: String?) {
        let content = UNMutableNotificationContent()
        content.title = "Sound Test"
        content.body = soundName == nil ? "Default sound" : "Playing \(soundName!) sound"
        
        // Set the sound
        if let soundName = soundName {
            // Custom sound
            content.sound = UNNotificationSound(named: UNNotificationSoundName("\(soundName).wav"))
        } else {
            // Default sound
            content.sound = UNNotificationSound.default
        }
        
        // Add image attachment
        if let image = UIImage(named: "appImage"),
           let imageData = image.jpegData(compressionQuality: 0.8) {
            let tempDir = FileManager.default.temporaryDirectory
            let imageURL = tempDir.appendingPathComponent("soundTest.jpg")
            
            do {
                try imageData.write(to: imageURL)
                let attachment = try UNNotificationAttachment(
                    identifier: "soundTestImage",
                    url: imageURL,
                    options: [UNNotificationAttachmentOptionsTypeHintKey: "public.jpeg"]
                )
                content.attachments = [attachment]
            } catch {
                print("Error creating notification attachment: \(error)")
            }
        }
        
        // Trigger after 2 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: "SoundTestNotification",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling sound notification: \(error)")
            } else {
                print("Sound notification scheduled with sound: \(soundName ?? "default")")
            }
        }
    }
    
    func scheduleNotificationWithBadge() {
        let content = UNMutableNotificationContent()
        content.title = "Notification with Badge"
        content.body = "This notification will update the app badge"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(
            identifier: "BadgeNotification",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling badge notification: \(error)")
            } else {
                print("Badge notification scheduled")
            }
        }
    }
    
    func scheduleSequentialNotification(imageName: String, count: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Sequential Notification"
        content.body = "This is notification number \(count)"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("audioSeq.wav"))
        content.userInfo = ["imageName": imageName]
        content.badge = NSNumber(value: count)
        
        // Add image attachment
        if let image = UIImage(named: imageName),
           let imageData = image.jpegData(compressionQuality: 0.8) {
            let tempDir = FileManager.default.temporaryDirectory
            let imageURL = tempDir.appendingPathComponent("\(imageName).jpg")
            
            do {
                try imageData.write(to: imageURL)
                let attachment = try UNNotificationAttachment(
                    identifier: "image",
                    url: imageURL,
                    options: [UNNotificationAttachmentOptionsTypeHintKey: "public.jpeg"]
                )
                content.attachments = [attachment]
                print("✅ Added image attachment for sequential notification")
            } catch {
                print("❌ Error creating notification attachment: \(error)")
            }
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(
            identifier: "SequentialNotification",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error scheduling sequential notification: \(error)")
            } else {
                print("✅ Scheduled sequential notification with image: \(imageName) and count: \(count)")
            }
        }
    }
} 
