//
//  SceneDelegate.swift
//  Notifi
//
//  Created by Deepanshu Bajaj on 19/05/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let splashScreen = SplashScreen()
        window?.rootViewController = splashScreen
        window?.makeKeyAndVisible()
    }
} 
