//
//  DBInfo.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/15/24.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct Info: Codable, Identifiable {
    @DocumentID var id: String? // Use @DocumentID for the document ID
    var title: String
    var caption: String
    var color: String // Store color as a string
    var image: String // Store image as a string
}

struct Course: Codable, Identifiable {
    @DocumentID var id: String? // Use @DocumentID for the document ID
    var title: String
    var subtitle: String
    var caption: String
    var color: String
    var image: String
    var videoURL: String
}

let db = Firestore.firestore()
let infoCollection = db.collection("infos")
let coursesCollection = db.collection("courses")

var infos = [
    Info(title: "Is Someone I Care About At Risk?", caption: "If you or a friend are thinking about suicide, reach out to one of these places immediately.", color: "blue", image: "worriedCare"),
    Info(title: "Warning Signs", caption: "If you feel like you are at risk for suicide, let's talk. You are not alone.", color: "red", image: "warningSigns"),
    Info(title: "Worried About A Friend?", caption: "Let your friend know they are not alone. You could save a life.", color: "purple", image: "worried"),
    Info(title: "What should I say?", caption: "Approaching a friend can be difficult, but you can make a difference.", color: "blue", image: "approach"),
    Info(title: "Using I Statements", caption: "How we talk is important, here are some tips on using language help a friend.", color: "red", image: "statements"),
]

var courses = [
    Course(title: "Things Can Get Better", subtitle: "teens describe common signs that a teen is considering suicide and provide encouragement for communicating directly and immediately for support and safety.", caption: "You Matter", color: "blue", image: "afy2", videoURL: "https://youtu.be/KTzHFmshdic"),
    Course(title: "Mental Health - Check In", subtitle: "There are more than 175,000 youth living with a mental illness who go undiagnosed each year. We can change that! Help us increase awareness of mental illnesses and provide support to those who are afraid to speak up.", caption: "You Are Not Alone", color: "red", image: "afy2", videoURL: "https://youtu.be/7VjliK3kGI0")
]

func saveInfosToFirestore() {
    // Save each Info object to Firestore
    for info in infos {
        do {
            try infoCollection.addDocument(from: info)
        } catch {
            print("Error saving info: \(error)")
        }
    }
}

func saveCoursesToFirestore() {
    // Save each Info object to Firestore
    for course in courses {
        do {
            try coursesCollection.addDocument(from: course)
        } catch {
            print("Error saving info: \(error)")
        }
    }
}

