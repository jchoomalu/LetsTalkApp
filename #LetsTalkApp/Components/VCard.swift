import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}

struct VCard: View {
    var course: Course
    @State private var isFlipped = false

    var videoEmbedHTML: String {
        guard let videoID = URL(string: course.videoURL)?.lastPathComponent else { return "" }
        return """
        <html><body style="margin:0;padding:0;"><iframe width="100%" height="100%" src="https://www.youtube.com/embed/\(videoID)?autoplay=1&playsinline=1" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></body></html>
        """
    }

    var body: some View {
           VStack {
               Spacer()
               HStack {
                   Spacer()
                   ZStack {
                       if !isFlipped {
                           frontView
                       } else {
                           // WebView with the video
                           WebView(htmlContent: videoEmbedHTML)
                               .edgesIgnoringSafeArea(.all)
                               .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                               .overlay(
                                   // Button to flip back
                                   Button(action: {
                                       withAnimation {
                                           isFlipped.toggle()
                                       }
                                   }) {
                                       Image(systemName: "arrow.uturn.left")
                                           .font(.title)
                                           .foregroundColor(.white)
                                           .padding()
                                           .background(Color.black.opacity(0.5))
                                           .clipShape(Circle())
                                   }
                                   .padding(.all, 20), // Adjust padding as needed
                                   alignment: .bottomLeading // Position of the button
                               )
                       }
                   }
                   .frame(width: isFlipped ? UIScreen.main.bounds.width : UIScreen.main.bounds.width - 40, height: 310)
                   .background(
                       Image("bg_VCardw")
                           .resizable()
                           .scaledToFill()
                   )
                   .cornerRadius(10)
                   .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 2)
                   .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                   .animation(.easeInOut(duration: 0.5), value: isFlipped)
                   Spacer()
               }
               Spacer()
           }
       }

    var frontView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(course.title)
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Text(course.subtitle)
                .opacity(0.9)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            Text(course.caption.uppercased())
                .font(.footnote)
                .opacity(0.7)
                .padding(.horizontal)
            Spacer()
            HStack {
               
                ForEach(Array([4, 5, 6].shuffled().enumerated()), id: \.offset) { index, number in
                    Image("Avatar \(number)")
                        .resizable()
                        .scaledToFit()
                        .mask(Circle())
                        .frame(width: 44, height: 44)
                        .offset(x: CGFloat(index * -20))
                }
                Spacer()
                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        isFlipped.toggle()
                                    }
                                }) {
                                    Image(systemName: "play")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.black.opacity(0.2))
                                        .clipShape(Circle())
                                }
                                .padding(.horizontal, 20) // Adjust padding as needed
                            }
                            .padding(.bottom, 10)
                            .padding(.leading, 20)
                        }
                        .foregroundColor(.white)
                        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .overlay(
                            Image(course.image)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                .padding(20)
                        )
                    }
                }
