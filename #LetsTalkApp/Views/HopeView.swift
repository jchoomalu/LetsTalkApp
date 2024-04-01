//
//  Hope.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/16/24.
//
import SwiftUI
import FirebaseFirestore
import RiveRuntime

struct HopeView: View {
    @State private var submissions: [Submission] = []
    @ObservedObject private var viewModel = FirestoreSubmissionsModel()
    @State private var userInput: String = ""
    @State private var showTextInput = false
    @State private var showingAvatarPicker = false
    @State private var showingNicknameEntry = false
    @State private var selectedAvatarName: String?
    @State private var nickname: String = ""
    @State private var expandedTextIndices: Set<String> = []
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("bgLight")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                RiveViewModel(fileName: "shapesLight")
                    .view()
                    .blur(radius: 20)
                    .edgesIgnoringSafeArea(.all)
                
                // List of submissions
                List(viewModel.submissions) { submission in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(submission.avatarName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text(submission.nickname)
                                    .font(.headline)
                                Text(submission.timestamp, style: .date)
                                    .font(.subheadline)
                            }
                        }
                        
                        if submission.text.count > 100 && !expandedTextIndices.contains(submission.id ?? "") {
                            Text("\(submission.text.prefix(100))...")
                                .onTapGesture {
                                    expandedTextIndices.insert(submission.id ?? "")
                                }
                            
                            HStack {
                                Spacer()
                                Text("Read More")
                                Image(systemName: "chevron.down")
                            }
                            .onTapGesture {
                                expandedTextIndices.insert(submission.id ?? "")
                            }
                            .foregroundColor(.blue)
                        } else {
                            Text(submission.text)
                            if submission.text.count > 100 {
                                HStack {
                                    Spacer()
                                    Text("Read Less")
                                    Image(systemName: "chevron.up")
                                }
                                .onTapGesture {
                                    expandedTextIndices.remove(submission.id ?? "")
                                }
                                .foregroundColor(.blue)
                            }
                        }
                    }
                    .padding(20)
                    
                }
                .cornerRadius(50)
                .padding(.vertical, 5)
                .shadow(radius: 10)
                .navigationTitle("Your Title")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingNicknameEntry = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                .padding()
                
            }
        }
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showingNicknameEntry) {
            NicknameEntryView(nickname: $nickname, showingNicknameEntry: $showingNicknameEntry, showingAvatarPicker: $showingAvatarPicker)
        }
        .sheet(isPresented: $showingAvatarPicker) {
            AvatarPickerView(selectedAvatarName: $selectedAvatarName,
                             showingAvatarPicker: $showingAvatarPicker,
                             showingTextInput: $showTextInput,
                             nickname: $nickname)
        }
        .sheet(isPresented: $showTextInput) {
            TextFieldView(userInput: $userInput, showingAvatarPicker: $showingAvatarPicker, selectedAvatarName: $selectedAvatarName, nickname: $nickname, onCommit: {
                if !userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    addDocumentWithText(userInput)
                }
                userInput = ""
                showTextInput = false
            }, onDone: {
                userInput = ""
                showTextInput = false
            })
        }
    }
    
    func addDocumentWithText(_ text: String) {
        let effectiveNickname = nickname.isEmpty ? "ItGetsBetter24" : nickname
        let db = Firestore.firestore()
        db.collection("submissions").addDocument(data: [
            "text": text,
            "approved": false,
            "timestamp": Timestamp(),
            "avatarName": selectedAvatarName ?? "defaultAvatar",
            "nickname": effectiveNickname
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added with nickname \(effectiveNickname)")
            }
        }
    }
    
    
    
    struct NicknameEntryView: View {
        @Binding var nickname: String
        @Binding var showingNicknameEntry: Bool
        @Binding var showingAvatarPicker: Bool
        let button = RiveViewModel(fileName: "letstalkbtn")
        
        var body: some View {
            ZStack {
                Image("bgLight")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .center, spacing: 20) {
                    VStack(alignment: .center, spacing: 10) {
                        ForEach(["Enter", "A", "Nickname"], id: \.self) { word in
                            Text(word)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.clear)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.purple.opacity(0.5)]), startPoint: .leading, endPoint: .trailing)
                                )
                                .mask(
                                    Text(word)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                )
                                .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 5)
                        }

                        TextField("Nickname", text: $nickname)
                            .padding()
                            .background(Color.white) // Set the background color to white
                            .cornerRadius(8) // Maintain rounded corners
                            .shadow(radius: 2) // Optional: Add a shadow for depth
                            .padding(.top, 50)
                            .padding(.bottom, 30)
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                               .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
                    }
                     button.view()
                        .frame(height: 65) 
                        .onTapGesture {
                            button.play(animationName: "active") // Play the animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                // Your action after the animation plays
                                if nickname.isEmpty {
                                    nickname = "ItGetsBetter24"
                                }
                                showingNicknameEntry = false
                                showingAvatarPicker = true
                            }
                        }
                        .cornerRadius(40)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                }
                .padding()
                .background(Image("bgLight").blur(radius: 10))
                .cornerRadius(12)
                .padding()
            }
        }
    }



    
    struct AvatarPickerView: View {
        @Binding var selectedAvatarName: String?
        @Binding var showingAvatarPicker: Bool
        @Binding var showingTextInput: Bool
        @Binding var nickname: String
        
        let avatars = ["lt_av_1", "lt_av_2", "lt_av_3"]
        
        var body: some View {
            ZStack {
                VStack(spacing: 20) {
                    Spacer()
                    Text(nickname.isEmpty ? "youthFriend" : nickname)
                        .font(.title)
                    Text("Choose an avatar for your post")
                        .font(.headline)
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(avatars, id: \.self) { avatar in
                                Image(avatar)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .shadow(radius: 3)
                                    .padding()
                                    .onTapGesture {
                                        selectedAvatarName = avatar
                                        showingAvatarPicker = false
                                        showingTextInput = true
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                    Spacer()
                }
            }.background(Image("bgLight"))
        }
    }
    
    struct TextFieldView: View {
        @Binding var userInput: String
        @Binding var showingAvatarPicker: Bool
        @Binding var selectedAvatarName: String?
        @Binding var nickname: String
        let onCommit: () -> Void
        let onDone: () -> Void
        
        var body: some View {
            NavigationView {
                ZStack {
                    VStack {
                        TextEditor(text: $userInput)
                            .frame(height: 200)
                            .padding()
                            .keyboardType(.default)
                        Button("Submit", action: onCommit)
                            .padding()
                        Spacer()
                    }
                    .navigationBarItems(trailing: Button("Done") {
                        onDone()
                    })
                }.background(Image("bgLight"))
            }
        }
    }
}
    
#Preview {
    HopeView()
}
