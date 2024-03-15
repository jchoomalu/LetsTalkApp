//
//  VCard.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/9/24.
//

import SwiftUI

struct CourseSection: Identifiable {
    var id = UUID()
    var title: String
    var caption: String
    var color: Color
    var image: Image
}

var courseSections = [
    CourseSection(title: "State Machine", caption: "Watch video - 15 mins", color: Color(.blue), image: Image("Topic 2")),
    CourseSection(title: "Animated Menu", caption: "Watch video - 10 mins", color: Color(.red), image: Image("Topic 1")),
    CourseSection(title: "Tab Bar", caption: "Watch video - 8 mins", color: Color(.purple), image: Image("Topic 2")),
    CourseSection(title: "Button", caption: "Watch video - 9 mins", color: Color(.pink), image: Image("Topic 1"))
]
