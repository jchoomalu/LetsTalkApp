import SwiftUI
import SafariServices

struct HCard: View {
    struct SafariView: UIViewControllerRepresentable {
        let url: URL

        func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
            return SFSafariViewController(url: url)
        }

        func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
            // No need to update the view controller in this use case.
        }
    }

    var article: Article
    @State private var isExpanded = false
    @State private var isExpandable = false
    @State private var showingSafariView = false

    private let characterLimitForTwoLines: Int = 100 // Adjust based on your font and layout

    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(article.title)
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(article.caption)
                                .font(.body)
                                .foregroundColor(.white)
                                .lineLimit(isExpanded ? nil : 2)
                                .onAppear {
                                    // Determine if the text is expandable
                                    self.isExpandable = article.caption.count > characterLimitForTwoLines
                                }
                            
                            if isExpandable {
                                Button(action: {
                                    withAnimation {
                                        self.isExpanded.toggle()
                                    }
                                }) {
                                    HStack {
                                        Text(isExpanded ? "Read Less" : "Read More")
                                            .foregroundColor(.blue)
                                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                            .foregroundColor(.blue)
                                    }
                                    .font(.caption)
                                }
                            }
                        }
                    }
                    Spacer() // Keeps the text aligned to the left
                }
                .padding(30)
                
                // Image positioned absolutely in the top right
                Image("afy1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 20) // Right padding inside the ZStack
                    .padding(.top, 20) // Top padding inside the ZStack
                
            }
            .frame(maxWidth: .infinity)
            .background(
                Image("hCard")
                    .resizable()
                    .scaledToFill()
            )
            .cornerRadius(30)
        }
        .padding(.horizontal)
        .onTapGesture {
            self.showingSafariView = true
        }
        .sheet(isPresented: $showingSafariView) {
            if let url = URL(string: article.articleURL) {
                SafariView(url: url)
            }
        }
    }
}
