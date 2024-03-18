//
//  AppDelegate.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/16/24.
//
import Foundation
import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Configure Firebase here
        FirebaseApp.configure()
        return true
    }

    // Implement any other delegate methods you need
}

