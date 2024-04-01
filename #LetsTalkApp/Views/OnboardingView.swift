//
//  OnboardingView.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/7/24.
//

import SwiftUI
import RiveRuntime

struct OnboardingView: View {
    let button = RiveViewModel(fileName: "letstalkbtn")
    @State var showModal = false
    
    
    var body: some View {
        ZStack {
            content
                .offset(y: showModal ? -80 : 0)
                .background(
                    Image("bgLight")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all) 
                )
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
            
            Spacer()
            
            Image("letsTalk")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width)
                .zIndex(1)
            Rectangle().frame(height: 1).opacity(0.1).padding(.horizontal)
            
            Spacer()
            
            button.view()
                .frame(height: 75)
                .overlay(
                    Label {
                        
                        Text("Let's Talk")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading, 35)
                    } icon: {
                        // Adjust the icon size to match your text if needed
                    }
                    .foregroundColor(.darkBlue)
                )
                
                .onTapGesture {
                    button.play(animationName: "active")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation(.spring()) {
                            showModal = true
                        }
                    }
                }
                .padding(.bottom)
            
            Spacer()
        }
        .padding([.leading, .trailing, .top])
    }
}

#Preview {
    OnboardingView()
}
