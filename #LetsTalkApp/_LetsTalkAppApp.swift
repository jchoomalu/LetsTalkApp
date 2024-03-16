//
//  _LetsTalkAppApp.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/7/24.
//

import SwiftUI
import Firebase
import UIKit

@main
struct _LetsTalkAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
