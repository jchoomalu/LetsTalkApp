//
//  VCard.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/9/24.
//

import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var caption: String
    var color: Color
    var image: Image
    var videoURL: String
}

var courses = [
    Course(title: "Things Can Get Better", subtitle: "teens describe common signs that a teen is considering suicide and provide encouragement for communicating directly and immediately for support and safety.", caption: "You Matter", color: Color(.blue), image: Image("afy2"), videoURL: "https://youtu.be/KTzHFmshdic"),
    Course(title: "Mental Health - Check In", subtitle: "There are more than 175,000 youth living with a mental illness who go undiagnosed each year. We can change that! Help us increase awareness of mental illnesses and provide support to those who are afraid to speak up.", caption: "You Are Not Alone", color: Color(.red), image: Image("afy2"), videoURL: "https://youtu.be/7VjliK3kGI0")
]
