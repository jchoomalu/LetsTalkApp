//
//  HomeView.swift
//  LetsTalkApp
//
//  Created by Jason Hoomalu 3/9/2024.
//

import SwiftUI
import WebKit
import AVKit
import RiveRuntime

struct HomeView: View {
    @State private var selectedCourse: Course?
    @ObservedObject var courseViewModel = FirestoreCourseModel()
    @ObservedObject var articleViewModel = FirestoreArticleModel()

    var body: some View {
        ZStack {
            Image("bgLight") // Use bgLight as the sole background
                .resizable()
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                content
            }
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 20) {
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                Text("Videos")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
            }
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(courseViewModel.courses) { course in
                        VCard(course: course)
                            .onTapGesture {
                                self.selectedCourse = course // Set the selected course when tapped
                            }
                    }
                }
            }
            
            VStack {
                Text("Articles")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack(spacing: 20) {
                    ForEach(articleViewModel.articles) { article in
                        HCard(article: article)
                    }
                }
            }
        }
    }
}
    


#Preview {
    HomeView()
}
