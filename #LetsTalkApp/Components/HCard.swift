//
//  VCard.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/9/24.
//

import SwiftUI

struct HCard: View {
    var article: Article // Corrected to use ':' for type declaration
    
    private var articleColor: Color {
        switch article.color.lowercased() {
        case "blue": return .blue
        case "red": return .red
        case "purple": return .purple
        // Add more cases as needed
        default: return .gray // Default color
        }
    }
    

    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.title2) // Use .font instead of .customFont unless you have a custom modifier
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(article.caption)
                    .font(.body) // Use .font instead of .customFont unless you have a custom modifier
            }
            Divider()
            Image(article.image) // Assuming the image is stored in your assets
                .resizable() // Make sure to make the image resizable
                .scaledToFit()
                .frame(width: 100, height: 100) // Adjust size as necessary
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: 110)
        .background(Color(articleColor))
        .cornerRadius(30) // Use .cornerRadius for rounding corners
    }
}

