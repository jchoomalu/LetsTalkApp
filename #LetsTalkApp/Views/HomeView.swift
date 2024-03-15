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
    
    var body: some View {
        ZStack {
            RiveViewModel(fileName: "shapes")
                .view()
                .blur(radius: 30)
                .background(
                    Image("Spline")
                        .blur(radius: 50)
                        .offset(x: 200, y: 200)
                )
            ScrollView {
                content
            }
        }
    }
        
        var content: some View {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                VStack(alignment: .leading, spacing: 0) {
                    Text("Videos")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(courses) { course in
                            VCard(course: course)
                                .onTapGesture {
                                    self.selectedCourse = course // Set the selected course when tapped
                                }
                        }
                    }
                    .padding(20)
                    .padding(.bottom, 10)
                }
                VStack {
                    Text("Articles")
                        .customFont(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(spacing: 20) {
                        ForEach(courseSections) { section in
                            HCard(section: section)
                        }
                    }
                }
                .padding(20)
            }
            .fullScreenCover(item: $selectedCourse) { course in
                VideoPlayerView(videoURLString: course.videoURL)
            }
            
        }
    
    }
    
    struct vCard: View {
        var course: Course
        
        var body: some View {
            Text(course.title)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }

    struct WebView: UIViewRepresentable {
        let url: URL
        
        func makeUIView(context: Context) -> WKWebView {
            let webView = WKWebView()
            webView.load(URLRequest(url: url))
            return webView
        }
        
        func updateUIView(_ uiView: WKWebView, context: Context) {
            // No need to implement updateUIView(_:context:) for now
        }
    }
    
    struct VideoPlayerView: View {
        var videoURLString: String
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            VStack {
                if let videoURL = URL(string: videoURLString) {
                    WebView(url: videoURL)
                } else {
                    Text("Invalid URL")
                }
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
        }
    }

        



#Preview {
    HomeView()
}
