//
//  SignInView.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/8/24.
//
import SwiftUI
import RiveRuntime

struct SideMenu: View {
    
    @AppStorage("selectedTab") var selectedTab: SelectedTab = .chat
    @Binding var isOpen: Bool
    
    var active = false
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image("arrowLogo")
                    .padding(12)
                   
                VStack(alignment: .leading, spacing: 2) {
                    Text("#Let'sTalk")
                        .font(.custom("LilitaOne-Regular", size: 24))
                }
                Spacer()
            }
            .padding()
            
            Text("BROWSE")
                .font(.subheadline).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 40)
                .opacity(0.7)
            
            browse
            Spacer()
        }
        .foregroundColor(.white)
        .frame(maxWidth: 288, maxHeight: .infinity)
        .background(Color("Background 2"))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color(.blue).opacity(0.3), radius: 40, x: 0, y: 20)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var browse: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(menuItems) { item in
                Rectangle()
                    .frame(height: 1)
                    .opacity(0.1)
                    .padding(.horizontal, 16)
                
                HStack(spacing: 14) {
                    item.icon.view()
                        .frame(width: 32, height: 32)
                        .opacity(0.6)
                    Text(item.text)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.blue)
                        .frame(maxWidth: selectedTab == item.menu ? .infinity : 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                )
                .background(Color("Background 2"))
                .onTapGesture {
                    selectedTab = item.menu // Mark the item as selected immediately
                    // Delay the closure execution for changing the isOpen state
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // 0.2 seconds delay
                        withAnimation(.spring()) {
                            isOpen = false
                        }
                    }
                }
            }
        }
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
    }
}

#Preview {
    SideMenu(isOpen: .constant(false))
}

struct MenuItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: RiveViewModel
    var menu: SelectedTab
    var view: AnyView // Change 'any View' to 'AnyView'
}

var menuItems: [MenuItem] = [
    MenuItem(text: "Let's Talk", icon: RiveViewModel(fileName: "icons", stateMachineName: "CHAT_Interactivity", artboardName: "CHAT"), menu: .chat, view: AnyView(LetsTalk())), // Use AnyView to wrap the view
    MenuItem(text: "Resources", icon: RiveViewModel(fileName: "icons", stateMachineName: "HOME_interactivity", artboardName: "HOME"), menu: .home, view: AnyView(HomeView())), // Use AnyView to wrap the view
    MenuItem(text: "When To Act", icon: RiveViewModel(fileName: "icons", stateMachineName: "TIMER_Interactivity", artboardName: "TIMER"), menu: .timer, view: AnyView(InfoView())),
    MenuItem(text: "Safe Spaces", icon: RiveViewModel(fileName: "icons", stateMachineName: "SEARCH_Interactivity", artboardName: "SEARCH"), menu: .map, view: AnyView(Map())),
    MenuItem(text: "Hope", icon: RiveViewModel(fileName: "icons", stateMachineName: "USER_Interactivity", artboardName: "USER"), menu: .user, view: AnyView(Text("Hope")))
]


