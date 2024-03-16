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
    @State private var selectedAvatarName: String?

    var body: some View {
        NavigationView {
            List(viewModel.submissions) { submission in
                HStack {
                    Image(submission.avatarName) // Assuming you have these images in your assets
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text(submission.text)
                }
            }
            .navigationTitle("Your Title")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAvatarPicker = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAvatarPicker) {
                AvatarPickerView(selectedAvatarName: $selectedAvatarName, showingAvatarPicker: $showingAvatarPicker, showingTextInput: $showTextInput)
            }
            .sheet(isPresented: $showTextInput) {
                NavigationView {
                    TextFieldView(userInput: $userInput, showingAvatarPicker: $showingAvatarPicker, selectedAvatarName: $selectedAvatarName, onCommit: {
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
    }
    
    func addDocumentWithText(_ text: String) {
        let db = Firestore.firestore()
        db.collection("submissions").addDocument(data: [
            "text": text,
            "approved": false,
            "timestamp": Timestamp(),
            "avatarName": selectedAvatarName ?? "defaultAvatar", // Default avatar logic here
            "dateSaved": Date()
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added")
            }
        }
    }
}

// AvatarPickerView to select an avatar
struct AvatarPickerView: View {
    @Binding var selectedAvatarName: String?
    @Binding var showingAvatarPicker: Bool
    @Binding var showingTextInput: Bool

    let avatars = ["avatar1", "avatar2", "avatar3"]

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
                            .frame(width: 80, height: 80) // Adjust size as needed
                            .clipShape(Circle()) // Make the avatars circular
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
// Modified TextFieldView to accept new bindings and control flow
struct TextFieldView: View {
    @Binding var userInput: String
    @Binding var showingAvatarPicker: Bool
    @Binding var selectedAvatarName: String?
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
