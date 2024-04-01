import SwiftUI
import RiveRuntime

struct InfoView: View {
        @ObservedObject var viewModel = FirestoreInfoModel()
        @State private var selectedInfo: Info?
        @State private var isPushed = false
    var body: some View {
         ZStack {
             background
            
             VStack {
                 Text("Information")
                     .font(.largeTitle)
                     .fontWeight(.bold)
                     .foregroundColor(.blue)
                     .padding(.top, 50)
                 
                 ScrollView(.vertical, showsIndicators: false) {
                     VStack(spacing: 20) {
                         ForEach(viewModel.infos) { info in
                             InfoCardView(info: info, isPushed: $isPushed, selectedInfo: $selectedInfo)
                         }
                     }
                     .padding()
                 }
                 Spacer()
             }
             .padding()
             .sheet(item: $selectedInfo, content: ModalView.init)
         }
         .ignoresSafeArea()
     }
     
     var background: some View {
         RiveViewModel(fileName: "shapesLight").view()
             .blur(radius: 20)
             .background(Image("bgLight"))
             .ignoresSafeArea()
             
     }
 }

struct InfoCardView: View {
    let info: Info
    @Binding var isPushed: Bool
    @Binding var selectedInfo: Info?
    
    var body: some View {
        Button(action: {
              self.selectedInfo = self.info
          }) {
              ZStack {
                  Image(info.image)
                      .resizable()
                      .scaledToFill()
                      .frame(width: 300, height: 110)
                      .clipped()
                      .overlay(
                          RoundedRectangle(cornerRadius: 15)
                              .fill(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.2), Color.black.opacity(0.2)]), startPoint: .top, endPoint: .bottom))
                      )

                  Text(info.title)
                      .foregroundColor(.white)
                      .font(.title2)
                      .fontWeight(.bold)
                      .shadow(color: .black.opacity(0.75), radius: 2, x: 1, y: 1)
                      .padding(.bottom, 5)
              }
          }
          .frame(width: 300, height: 110)
          .cornerRadius(15)
          .shadow(color: .gray, radius: 10, x: 0, y: 4)
      }
  }

    
    struct ModalView: View {
        let info: Info
        
        var body: some View {
            ZStack {
                RiveViewModel(fileName: "shapes").view()
                    .ignoresSafeArea()
                    .blur(radius: 30)
                    .background(
                        Image("bgLight")
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
                    Image(info.image)
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .cornerRadius(20)
                        .padding(.bottom, -38)
                }
            }
        }
    }

struct ResourceInfo: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var caption: String
    var image: Image

    static func == (lhs: ResourceInfo, rhs: ResourceInfo) -> Bool {
        return lhs.id == rhs.id
    }
}




// Preview struct
#Preview {
    InfoView()
}
