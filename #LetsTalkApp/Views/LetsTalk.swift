//
//  SignInView.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/8/24.
//

import SwiftUI

struct LetsTalk: View {
    @State private var phoneIconScale: CGFloat = 1.0
    @State private var msgIconScale: CGFloat = 1.0
    var body: some View {
        VStack(spacing: 24) {
            Text("Let's Talk")
                .customFont(.largeTitle)
            Text("Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum")
                .customFont(.headline)
            Text("Call Now")
                .customFont(.subheadline)
                .foregroundColor(.secondary)
            Divider()
            Text("How would you like to talk?")
                .customFont(.subheadline)
                .foregroundColor(.secondary)
            HStack {
                Image("phoneIcon")
                    .scaleEffect(phoneIconScale) // Apply the scale effect
                    .onTapGesture {
                        // Animation for tap
                        withAnimation {
                            self.phoneIconScale = 0.8
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                self.phoneIconScale = 1.0
                            }
                        }
                        // Open the phone app
                        if let url = URL(string: "tel:988"), UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }
                
                HStack {
                    Rectangle().frame(height: 1).opacity(0.1)
                    Text("OR").customFont(.subheadline2).foregroundColor(.black.opacity(0.3))
                    Rectangle().frame(height: 1).opacity(0.1)
                }
                
                Image("msgIcon")
                    .scaleEffect(msgIconScale) // Apply the scale effect
                    .onTapGesture {
                        // Animation for tap
                        withAnimation {
                            self.msgIconScale = 0.8
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                self.msgIconScale = 1.0
                            }
                        }
                        // Open the messaging app
                        if let url = URL(string: "sms:741741"), UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }
            }.padding(20)
        }
        .padding(30)
        .background(.regularMaterial)
        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x:0, y: 3)
        .shadow(color: Color("Shadow").opacity(0.3), radius: 30, x:0, y: 30)
        .overlay(RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/).stroke(.linearGradient(colors: [.white.opacity(0.1), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing)))
        .padding()
    }
}

#Preview {
    LetsTalk()
}
