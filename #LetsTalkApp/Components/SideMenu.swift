import SwiftUI
import RiveRuntime

struct SideMenu: View {
    
    @AppStorage("selectedMenu") var selectedMenu: SelectedMenu = .help
    
    var active = false
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image("afy2")
                    .padding(12)
                    .background(.white.opacity(0.8))
                    .mask(Circle())
                VStack(alignment: .leading, spacing: 2) {
                    Text("Let's Talk")
                    Text("YOU MATTER")
                        .font(.subheadline)
                        .opacity(0.7)
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
            
            Text("EMERGENCY")
                .font(.subheadline).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 40)
                .opacity(0.7)
            
            history
            
            Spacer()
            
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12)
                .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding(8)
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
                        .frame(maxWidth: selectedMenu == item.menu ? .infinity : 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                )
                .background(Color("Background 2"))
                .onTapGesture {
                    withAnimation(.timingCurve(0.2, 0.8, 0.2, 1)) {
                        selectedMenu = item.menu
                    }
                    item.icon.setInput("active", value: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        item.icon.setInput("active", value: false)
                    }
                }
            }
        }
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
    }
    
    var history: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(menuItems2) { item in
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
                        .frame(maxWidth: selectedMenu == item.menu ? .infinity : 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                )
                .background(Color("Background 2"))
                .onTapGesture {
                    withAnimation(.timingCurve(0.2, 0.8, 0.2, 1)) {
                        selectedMenu = item.menu
                    }
                    item.icon.setInput("active", value: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        item.icon.setInput("active", value: false)
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
    SideMenu()
}

struct MenuItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: RiveViewModel
    var menu: SelectedMenu
}

var menuItems = [
    MenuItem(text: "Let's Talk", icon: RiveViewModel(fileName: "icons", stateMachineName: "CHAT_Interactivity", artboardName: "CHAT"), menu: .help),
    MenuItem(text: "Resurces", icon: RiveViewModel(fileName: "icons", stateMachineName: "HOME_interactivity", artboardName: "HOME"), menu: .home),
    MenuItem(text: "When To Act", icon: RiveViewModel(fileName: "icons", stateMachineName: "TIMER_Interactivity", artboardName: "TIMER"), menu: .timer),
    MenuItem(text: "Hope", icon: RiveViewModel(fileName: "icons", stateMachineName: "USER_Interactivity", artboardName: "USER"), menu: .user)
]

var menuItems2 = [
    MenuItem(text: "CALL 911", icon: RiveViewModel(fileName: "icons", stateMachineName: "STAR_Interactivity", artboardName: "LIKE/STAR"), menu: .history),
]


enum SelectedMenu: String {
    case home
    case timer
    case user
    case help
    case history
}
