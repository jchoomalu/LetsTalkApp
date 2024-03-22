//
//  OnboardingView.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/7/24.
//

import SwiftUI
import RiveRuntime

struct OnboardingView: View {
    let button = RiveViewModel(fileName: "green_btn")
    @State var showModal = false
    var body: some View {
        ZStack {
            content
                .offset(y: showModal ? -80 : 0)
                .background(Image("bgLight"))
            Color("Shadow")
                .opacity(showModal ? 0.4 : 0)
                .ignoresSafeArea()
            if showModal {
                LetsTalk()
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .overlay(
                        Button {
                            withAnimation(.spring()) {
                                showModal = false
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .frame(width: 36, height: 36)
                                .foregroundColor(.black)
                                .background(.white)
                                .mask(Circle())
                                .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
                        }
                            .frame(maxHeight: .infinity, alignment: .bottom)
                    )
                    .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                
            }
        }
    }
    
    var content: some View {
        VStack {
            Spacer() // Adds a dynamic spacer that pushes content down
            
            Image("lt_ob1")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width) // Adjusts the width to match the screen width
                .zIndex(1)
            Rectangle().frame(height: 1).opacity(0.1).padding(.horizontal)
            
            Spacer()
            
            button.view()
                .frame(height: 75)
                .overlay(
                    Label("Let's Talk", systemImage: "bubble.left.and.bubble.right")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.clear)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.green.opacity(0.5),
                                                                       Color.blue.opacity(0.5)                             ]), startPoint: .leading, endPoint: .trailing)
                        )
                        .mask(
                            Label("Let's Talk", systemImage: "bubble.left.and.bubble.right")
                                .font(.title2)
                                .fontWeight(.bold)
                        )
                )
                .background(
                    Color.black
                        .cornerRadius(30)
                        .blur(radius: 30)
                        .opacity(0.2)
                        .offset(y: 10)
                )
                .onTapGesture {
                    button.play(animationName: "active")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation(.spring()) {
                            showModal = true
                        }
                    }
                }
                .padding(.bottom) // Adds padding at the bottom
            
            Spacer() // Ensures there's space at the very bottom
        }
        .padding([.leading, .trailing, .top]) // Add padding to the leading, trailing, and top edges
    }
}

#Preview {
    OnboardingView()
}
