//
//  MultipleNotificationManager.swift
//  Notifi
//
//  Created by Deepanshu Bajaj on 19/05/25.
//

import UIKit
import UserNotifications

class MultipleNotificationManager {
    static let shared = MultipleNotificationManager()
    
    private init() {}
    
    // Helper function to convert number to word
    private func numberToWord(_ number: Int) -> String {
        let words = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
        return words[number - 1]
    }
    
    func scheduleMultipleNotifications(count: Int) {
        // Cancel any existing notifications
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        // Schedule new notifications
        for i in 1...count {
            let content = UNMutableNotificationContent()
            content.title = "Multiple Notification \(i)"
            content.body = "This is notification \(i) of \(count)"
            
            // Alternate between audioA1 and audioA2
            let soundName = i % 2 == 1 ? "audioA1" : "audioA2"
            content.sound = UNNotificationSound(named: UNNotificationSoundName("\(soundName).wav"))
            
            // Set badge count for each notification
            content.badge = NSNumber(value: i)
            
            // Add image attachment
            if let image = UIImage(named: "\(numberToWord(i))"),
               let imageData = image.jpegData(compressionQuality: 0.8) {
                let tempDir = FileManager.default.temporaryDirectory
                let imageURL = tempDir.appendingPathComponent("\(numberToWord(i)).jpg")
                
                do {
                    try imageData.write(to: imageURL)
                    let attachment = try UNNotificationAttachment(
                        identifier: "image\(i)",
                        url: imageURL,
                        options: [UNNotificationAttachmentOptionsTypeHintKey: "public.jpeg"]
                    )
                    content.attachments = [attachment]
                    print("✅ Added image attachment for notification \(i)")
                } catch {
                    print("❌ Error creating notification attachment: \(error)")
                }
            } else {
                print("❌ Failed to create image data for \(numberToWord(i))")
            }
            
            // Create trigger with 2-second intervals
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(2 * i), repeats: false)
            
            // Create request
            let request = UNNotificationRequest(
                identifier: "MultipleNotification\(i)",
                content: content,
                trigger: trigger
            )
            
            // Schedule notification
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("❌ Error scheduling notification \(i): \(error)")
                } else {
                    print("✅ Scheduled notification \(i) with sound: \(soundName) and badge: \(i)")
                }
            }
        }
    }
} 