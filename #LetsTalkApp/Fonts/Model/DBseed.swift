//
//  DBseed.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/15/24.
//

import Foundation
import FirebaseFirestore
import Combine

class FirestoreInfoModel: ObservableObject {
    @Published var infos: [Info] = []

    private var db = Firestore.firestore()

    init() {
        fetchData()
    }

    func fetchData() {
        db.collection("infos").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            self.infos = querySnapshot?.documents.compactMap { document -> Info? in
                try? document.data(as: Info.self)
            } ?? []
        }
    }
}

class FirestoreCourseModel: ObservableObject {
    @Published var courses: [Course] = []

    private var db = Firestore.firestore()

    init() {
        fetchData()
    }

    func fetchData() {
        db.collection("courses").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            self.courses = querySnapshot?.documents.compactMap { document -> Course? in
                try? document.data(as: Course.self)
            } ?? []
        }
    }
}
