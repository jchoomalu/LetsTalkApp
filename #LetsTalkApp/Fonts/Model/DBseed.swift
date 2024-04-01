//
//  DBseed.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/15/24.
//

import Foundation
import Combine
import FirebaseFirestoreSwift
import Firebase

struct Info: Codable, Identifiable {
    @DocumentID var id: String? // Use @DocumentID for the document ID
    var title: String
    var caption: String
    var image: String // Store image as a string
}

// Videos section in courses
struct Course: Codable, Identifiable {
    @DocumentID var id: String? // Use @DocumentID for the document ID
    var title: String
    var subtitle: String
    var caption: String
    var image: String
    var videoURL: String
}

struct Article: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var caption: String
    var articleURL: String
}



struct Submission: Codable, Identifiable {
    @DocumentID var id: String?
    var text: String
    var approved: Bool
    let avatarName: String
    let timestamp: Date
    let nickname: String
}



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

class FirestoreArticleModel: ObservableObject {
    @Published var articles: [Article] = []

    private var db = Firestore.firestore()

    init() {
        fetchData()
    }

    func fetchData() {
        db.collection("articles").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting articles: \(error.localizedDescription)")
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("No articles found")
                return
            }

            print("Fetched \(documents.count) articles")
            self.articles = documents.compactMap { document -> Article? in
                do {
                    return try document.data(as: Article.self)
                } catch {
                    print("Error decoding article: \(error)")
                    return nil
                }
            }
            if self.articles.isEmpty {
                print("No articles could be decoded, or articles are empty")
            }
        }
    }


}

class FirestoreSubmissionsModel: ObservableObject {
    @Published var submissions: [Submission] = []
    private var db = Firestore.firestore()
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        db.collection("submissions").whereField("approved", isEqualTo: true).getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.submissions = querySnapshot?.documents.compactMap { document -> Submission? in
                    try? document.data(as: Submission.self)
                } ?? []
            }
        }
    }
}


enum SelectedTab: String {
    case chat
    case home
    case timer
    case map
    case user
}
