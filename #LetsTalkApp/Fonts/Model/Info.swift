//
//  VCard.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/9/24.
//

import SwiftUI
import RiveRuntime

struct Info: Identifiable {
    var id = UUID()
    var title: String
    var caption: String
    var color: Color
    var image: Image
}

var infos = [
    Info(title: "Is Someone I Care About At Risk?", caption: "If you or a friend are thinking about suicide, reach out to one of these places immediately.", color: Color(.blue), image: Image("worriedCare")),
    Info(title: "Warning Signs", caption: "If you feel like you are at risk for suicide, let's talk. You are not alone.", color: Color(.red), image: Image("warningSigns")),
    Info(title: "Worried About A Friend?", caption: "Let your friend know they are not alone. You could save a life.", color: Color(.purple), image: Image("worried")),
    Info(title: "What should I say?", caption: "Approaching a friend can be difficult, but you can make a difference.", color: Color(.blue), image: Image("approach")),
    Info(title: "Using I Statements", caption: "How we talk is important, here are some tips on using language help a friend.", color: Color(.red), image: Image("statements")),
]
