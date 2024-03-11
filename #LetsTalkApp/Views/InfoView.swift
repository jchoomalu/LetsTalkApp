import SwiftUI
import RiveRuntime

struct InfoView: View {
    @State private var selectedInfo: Info?
    @State private var isPushed = false
    var body: some View {
        ZStack {
            // Assuming RiveViewModel(fileName: "shapes").view() sets a background
            RiveViewModel(fileName: "shapes").view()
                .ignoresSafeArea()
                .blur(radius: 30)
                .background(
                    Image("Spline")
                        .blur(radius: 50)
                        .offset(x: 200, y: 200)
                )
            // Main content layout
            VStack {
                // Resources title
                Text("Resources")
                    .font(.largeTitle) // Use a larger font size for the title
                    .fontWeight(.bold) // Make the title bold
                    .foregroundColor(.white)
                    .padding(.bottom, 50)

                // Rectangles representing resources
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) { // Increase spacing for a cleaner look
                        ForEach(infos) { info in
                            ZStack {
                                Rectangle()
                                    .fill(info.color)
                                    .frame(width: 300, height: 100) // Adjust size as needed
                                    .cornerRadius(15) // Rounded corners
                                    .scaleEffect(self.isPushed ? 0.95 : 1.0)
                                    .onTapGesture {
                                        withAnimation {
                                            self.isPushed.toggle()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                self.selectedInfo = info
                                                self.isPushed.toggle()
                                            }
                                        }
                                    }
                                    Text(info.title)
                                    .foregroundColor(.white)
                                    .fontWeight(.medium) // Optionally adjust font weight
                            }
                            .onTapGesture {
                                self.selectedInfo = info
                            }
                        }
                    }
                    .padding()
                }
                Spacer()
                Spacer()
            }
            .padding()
            .sheet(item: $selectedInfo) { info in
                ModalView(info: info)
            }
        }.ignoresSafeArea()
    }

    struct ModalView: View {
        let info: Info

        var body: some View {
            ZStack {
                RiveViewModel(fileName: "shapes").view()
                    .ignoresSafeArea()
                    .blur(radius: 30)
                    .background(
                        Image("Spline")
                            .blur(radius: 50)
                            .offset(x: -65, y: -85)
                    )
                VStack {
                    Text(info.title)
                        .font(.largeTitle)
                        .bold()
                        .padding(10)

                    Text(info.caption)
                        .font(.title3) 
                        .padding(.horizontal)

                    info.image
                        .resizable()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .cornerRadius(20)
                                .padding(.bottom, -38)
                }
            }
        }
    }

}

// Preview struct
#Preview {
    InfoView()
}
