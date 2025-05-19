//
//  AppDelegate.swift
//  Notifi
//
//  Created by Deepanshu Bajaj on 19/05/25.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Request notification permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("✅ Notification permission granted")
            } else if let error = error {
                print("❌ Error requesting notification permission: \(error)")
            }
        }
        
        // Set notification delegate
        UNUserNotificationCenter.current().delegate = self

        // Reset badge on launch
        resetBadgeCount(reason: "app launch")
        
        // Set up window
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        resetBadgeCount(reason: "app became active")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        resetBadgeCount(reason: "app entering foreground")
    }

    // This method is now optional. You can remove it unless you have other logic to do here.
    /*
    func applicationDidEnterBackground(_ application: UIApplication) {
        resetBadgeCount(reason: "app entered background")
    }
    */

    // MARK: - Notification Delegate Methods

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        resetBadgeCount(reason: "notification received in foreground")
        completionHandler([.banner, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        resetBadgeCount(reason: "notification tapped")

        let userInfo = response.notification.request.content.userInfo
        print("📲 Notification tapped with userInfo: \(userInfo)")

        if let imageName = userInfo["imageName"] as? String,
           let viewController = window?.rootViewController as? ViewController {
            print("🖼️ Updating image in ViewController")
            DispatchQueue.main.async {
                viewController.updateImage(with: imageName)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    viewController.verifyCurrentImage()
                }
            }
        }

        completionHandler()
    }

    // MARK: - Helper

    func resetBadgeCount(reason: String) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        print("🔄 Badge count reset to 0 (\(reason))")
    }
}
 
