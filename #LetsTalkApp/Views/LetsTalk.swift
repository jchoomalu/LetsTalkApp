import SwiftUI
import UIKit

struct LetsTalk: View {
    @State private var phoneIconScale: CGFloat = 1.0
    @State private var msgIconScale: CGFloat = 1.0

    var body: some View {
        VStack(spacing: 24) {
            Image("people1")
                .resizable()
                .scaledToFill()
            Divider()
            Text("How would you like to talk?")
                .customFont(.headline)
                .foregroundColor(.secondary)
            HStack {
                Image("phoneIcon")
                    .resizable()
                    .frame(width: 70, height: 80)
                    .scaleEffect(phoneIconScale)
                    .onTapGesture {
                        // Animation for tap
                        withAnimation {
                            self.phoneIconScale = 0.8
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                self.phoneIconScale = 1.0
                            }
                        }
                        phoneCallButtonAction()
                    }

                HStack {
                    Rectangle().frame(height: 1).opacity(0.1)
                    Text("OR").customFont(.subheadline2).foregroundColor(.black.opacity(0.3))
                    Rectangle().frame(height: 1).opacity(0.1)
                }.padding()

                Image("msgIcon")
                    .resizable()
                    .frame(width: 70, height: 80)
                    .scaleEffect(msgIconScale)
                    .onTapGesture {
                        // Animation for tap
                        withAnimation {
                            self.msgIconScale = 0.8
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                self.msgIconScale = 1.0
                            }
                        }
                        if let url = URL(string: "sms:+1741741"), UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }
            }.padding(20)
        }
        .padding(30)
        .background(
            Image("bgWhite") // Use your "bgWhite" image as the background
                .resizable()
                .scaledToFill()
        )
        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
        .shadow(color: Color("Shadow").opacity(0.3), radius: 30, x: 0, y: 30)
        .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(.linearGradient(colors: [.white.opacity(0.1), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing)))
        .padding()
    }
}

private func phoneCallButtonAction() {
    let phoneNumber: String = "988"
    if let url = URL(string: "tel://" + phoneNumber), UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url)
    }
}

#Preview {
    LetsTalk()
}
