//
//  VCard.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/9/24.
//

import SwiftUI

struct VCard: View {
    var course: Course

    // Convert color string to SwiftUI Color
    private var courseColor: Color {
        switch course.color.lowercased() {
        case "blue": return .blue
        case "red": return .red
        case "purple": return .purple
        // Add more cases as needed
        default: return .gray // Default color
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(course.title)
                .font(.title2) // Adjusted for simplicity; replace with your customFont modifier if needed
                .frame(maxWidth: 170, alignment: .leading)
                .layoutPriority(1)
            Text(course.subtitle)
                .opacity(0.7)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(course.caption.uppercased())
                .font(.footnote) // Adjusted for simplicity; replace with your customFont modifier if needed
                .opacity(0.7)
            Spacer()
            HStack {
                ForEach(Array([4, 5, 6].shuffled().enumerated()), id: \.offset) { index, number in
                    Image("Avatar \(number)") // Ensure "Avatar X" are valid image assets in your project
                        .resizable()
                        .scaledToFit()
                        .mask(Circle())
                        .frame(width: 44, height: 44)
                        .offset(x: CGFloat(index * -20))
                }
            }
        }
        .foregroundColor(.white)
        .padding(30)
        .frame(width: 260, height: 310)
        .background(
            LinearGradient(gradient: Gradient(colors: [courseColor.opacity(1), courseColor.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: courseColor.opacity(0.3), radius: 8, x: 0, y: 12)
        .shadow(color: courseColor.opacity(0.3), radius: 2, x: 0, y: 1)
        .overlay(
            Image(course.image) // Ensure this matches an image asset in your project
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(20)
        )
    }
}


