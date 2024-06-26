//
//  ContentView.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/7/24.
//

import SwiftUI
import RiveRuntime
struct ContentView: View {
    
    @AppStorage("selectedTab") var selectedTab: SelectedTab = .chat
    @State var isOpen = false
    @State var show = false
    @State private var refreshToggle: Bool = false
    
    let button = RiveViewModel(fileName: "menu_button", stateMachineName: "State Machine", autoPlay: false)
    
    var body: some View {
        ZStack {
            Color(.clear)
                .ignoresSafeArea()
            SideMenu(isOpen: $isOpen)
                .padding(.top, 50)
                .opacity(isOpen ? 1 : 0)
                .offset(x: isOpen ? 0 : -300)
                .rotation3DEffect(.degrees(isOpen ? 0 : 30), axis: (x: 0, y: 1, z: 0))
                .ignoresSafeArea(.all, edges: .top)
            Group {
                switch selectedTab {
                case .chat:
                    OnboardingView()
                case .home:
                    HomeView()
                case .timer:
                    InfoView()
                case .map:
                    Map()
                case .user:
                    HopeView()
                }
            }
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 80)
            }
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 104)
            }
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .rotation3DEffect(.degrees(isOpen ? 30 : 0), axis: (x: 0, y: -1, z: 0), perspective: 1)
            .offset(x: isOpen ? 265 : 0)
            .scaleEffect(isOpen ? 0.9 : 1)
            .scaleEffect(show ? 0.92 : 1)
            .ignoresSafeArea()
            TabBar()
                .offset(y: -24)
                .background(
                    LinearGradient(colors: [Color("Background").opacity(0), Color("Background")], startPoint: .top, endPoint: .bottom)
                        .frame(height: 150)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .allowsHitTesting(false)
                )
                .ignoresSafeArea()
                .offset(y: isOpen ? 300 : 0)
                .offset(y: show ? 200 : 0)
            button.view()
                .frame(width: 54, height: 54)
                .mask(Circle())
                .shadow(color: Color("Shadow").opacity(0.7), radius: 8, x: 0, y: 5)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .offset(x: isOpen ? 216 : 0)
                .onTapGesture {
                    button.setInput("isOpen", value: isOpen)
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        isOpen.toggle()
                    }
                }
                .onChange(of: isOpen) {
                    button.setInput("isOpen", value: isOpen)
                    refreshToggle.toggle()
                }
                .id(refreshToggle)
        }
    }
}


#Preview {
    ContentView()
}
