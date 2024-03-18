//
//  Hope.swift
//  #LetsTalkApp
//
//  Created by Jason Hoomalu on 3/16/24.
//
import SwiftUI
import FirebaseFirestore

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
                    
                    Divider().background(Color.gray.opacity(0.5))
                    
                    if submission.text.count > 100 && !expandedTextIndices.contains(submission.id ?? "") {
                        Text("\(submission.text.prefix(100))... ")
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
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    } else {
                        Text(submission.text)
                            .onTapGesture {
                                expandedTextIndices.remove(submission.id ?? "")
                            }
                        HStack {
                            Spacer()
                            Text("Read Less")
                            Image(systemName: expandedTextIndices.contains(submission.id ?? "") ? "chevron.up" : "chevron.down")
                                
                        }.onTapGesture {
                            let contains = expandedTextIndices.contains(submission.id ?? "")
                            if contains {
                                expandedTextIndices.remove(submission.id ?? "")
                            } else {
                                expandedTextIndices.insert(submission.id ?? "")
                            }
                        }
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                }
                .padding()
            }
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
        }
        .sheet(isPresented: $showingNicknameEntry) {
            NicknameEntryView(nickname: $nickname, showingNicknameEntry: $showingNicknameEntry, showingAvatarPicker: $showingAvatarPicker)
                .background(Image("bgWhite").resizable().scaledToFill().edgesIgnoringSafeArea(.all))
        }
        
        .sheet(isPresented: $showingAvatarPicker) {
            AvatarPickerView(selectedAvatarName: $selectedAvatarName, showingAvatarPicker: $showingAvatarPicker, showingTextInput: $showTextInput)
                .background(Image("bgWhite").resizable().scaledToFill().edgesIgnoringSafeArea(.all))
        }
        .sheet(isPresented: $showTextInput) {
            NavigationView {
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
    }

    func addDocumentWithText(_ text: String) {
        let db = Firestore.firestore()
        db.collection("submissions").addDocument(data: [
            "text": text,
            "approved": false,
            "timestamp": Timestamp(),
            "avatarName": selectedAvatarName ?? "defaultAvatar",
            "nickname": nickname
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added with nickname \(nickname)")
            }
        }
    }
}


struct NicknameEntryView: View {
    @Binding var nickname: String
    @Binding var showingNicknameEntry: Bool
    @Binding var showingAvatarPicker: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter your nickname:")
                .font(.headline)
            
            TextField("Nickname", text: $nickname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Next") {
                showingNicknameEntry = false
                showingAvatarPicker = true
            }
            .padding()
        }
        .padding()
    }
}

struct AvatarPickerView: View {
    @Binding var selectedAvatarName: String?
    @Binding var showingAvatarPicker: Bool
    @Binding var showingTextInput: Bool

    let avatars = ["lt_av_1", "lt_av_2", "lt_av_3"]

    var body: some View {
        VStack(spacing: 20) {
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
    }
}

struct TextFieldView: View {
    @Binding var userInput: String
    @Binding var showingAvatarPicker: Bool
    @Binding var selectedAvatarName: String?
    @Binding var nickname: String // Added nickname binding
    let onCommit: () -> Void
    let onDone: () -> Void

    var body: some View {
        NavigationView {
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
        }
    }
}

    
#Preview {
   HopeView()
}
