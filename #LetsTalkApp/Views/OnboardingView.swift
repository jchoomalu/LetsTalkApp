//
//  OnboardingView.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/7/24.
//

import SwiftUI
import RiveRuntime

struct OnboardingView: View {
    let button = RiveViewModel(fileName: "button")
    @State var showModal = false
    var body: some View {
        ZStack {
            background
            content
                .offset(y: showModal ? -80 : 0)
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
        VStack(alignment: .leading, spacing: 16) {
            
            Text("YOU matter. Let's TALK.")
                .font(.custom("Poppins Bold", size: 52, relativeTo: .largeTitle))
                .frame(width: 260, alignment: .leading)
            Text("You are not alone. Find someone to call or text not. You have options, give us a chance.")
                .customFont(.title)
                .opacity(0.7)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            Spacer()
            button.view()
                .overlay(
                    Label("Let's Talk", systemImage: "bubble.left.and.bubble.right")
                        .offset(x:4, y:4)
                        .font(.headline)
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
                        withAnimation(.spring())  {
                            showModal = true
                        }
                    }
                }
         Spacer()
        Spacer()
        }
        .padding(20)
        .padding(.top, 40)
    }
    
    var background: some View {
        RiveViewModel(fileName: "shapes").view()
            .ignoresSafeArea()
            .blur(radius: 30)
            .background(
                Image("Spline")
                    .blur(radius: 50)
                    .offset(x: 200, y: 200)
            )
    }
    
}

#Preview {
    OnboardingView()
}