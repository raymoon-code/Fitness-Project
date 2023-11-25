//
//  AddExerciseView.swift
//  Fitness Project
//
//  Created by Tran Phat on 11/24/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
struct AddExerciseView: View {
    @State private var name = ""
    @State private var type = ""
    @State private var muscle = ""
    @State private var equipment = ""
    @State private var difficulty = ""
    @State private var instructions = ""
    @State private var imageURL = ""
    @State private var videoURL = ""
    @State private var showAlert = false
    var body: some View {
        GeometryReader { geo in
            let geow = geo.size.width
            let geoh = geo.size.height
            ZStack(alignment: .top){
                Rectangle()
                    .background(Color(red: 0.625, green: 0.909, blue: 0.965))
                    .zIndex(1)
                    .frame(height: geoh * 0.0001)
                //                Text("New Exercise")
                Section( header: Text("New Exercise")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.black)  )
                {
                    VStack {
                        TextField("Name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        TextField("type", text: $type)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        TextField("muscle", text: $muscle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        TextField("equipment", text: $equipment)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        TextField("difficulty", text: $difficulty)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        TextField("instructions", text: $instructions)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        TextField("imageURL", text: $imageURL)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        TextField("videoURL", text: $videoURL)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        // Add similar input fields for other properties of `todo`
                        
                        Button(action: {
                            let db = Firestore.firestore()
                            let collectionRef = db.collection("exercises")
                            let documentID = UUID().uuidString
                            
                            let newExerciseData: [String: Any] = [
                                "id": documentID,
                                "name": name,
                                "type": type,
                                "muscle": muscle,
                                "equipment": equipment,
                                "difficulty": difficulty,
                                "instructions": instructions,
                                "imageURL": imageURL,
                                "videoURL": videoURL
                            ]
                            
                            collectionRef.document(documentID).setData(newExerciseData) { error in
                                if let error = error {
                                    print("Error adding document: \(error)")
                                } else {
                                    print("Document added successfully with ID: \(documentID)")
                                    // Clear the input fields after adding the document
                                    name = ""
                                    type = ""
                                    muscle = ""
                                    equipment = ""
                                    difficulty = ""
                                    instructions = ""
                                    imageURL = ""
                                    videoURL = ""
                                    showAlert = true
                                }
                            }
                        }) {
                            Text("Add Exercise")
                              
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Exercise Added"), message: Text("Exercise has been added successfully"), dismissButton: .default(Text("OK")){
                            name = ""
                            type = ""
                            muscle = ""
                            equipment = ""
                            difficulty = ""
                            instructions = ""
                            imageURL = ""
                            videoURL = ""
                            ViewModelexercises().getData()
                            showAlert = false
                        })
                    }
                }
            }
        }
    }
}
        
#Preview {
    AddExerciseView()
}
