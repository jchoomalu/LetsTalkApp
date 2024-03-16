//
//  _LetsTalkAppApp.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/7/24.
//

import SwiftUI
import Firebase

@main
struct _LetsTalkAppApp: App {
    init() {
        FirebaseApp.configure()
        // seeds
        saveInfosToFirestore()
        saveCoursesToFirestore()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
