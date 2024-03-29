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
    @State private var showAlert2 = false
    
    @Binding var Email: String
    
    var isFormValid: Bool {
            !name.isEmpty && !type.isEmpty && !muscle.isEmpty && !equipment.isEmpty &&
            !difficulty.isEmpty && !instructions.isEmpty && !imageURL.isEmpty && !videoURL.isEmpty
        }
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
                    VStack(spacing:1) {
                        Text("")
                          
                            TextField("Name", text: $name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                           
                      
                        TextField("type", text: $type)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .autocapitalization(.none)
                        TextField("muscle", text: $muscle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .autocapitalization(.none)
                        TextField("equipment", text: $equipment)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .autocapitalization(.none)
                        TextField("difficulty", text: $difficulty)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .autocapitalization(.none)
                        
                        TextField("instructions", text: $instructions)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .autocapitalization(.none)
                        
                        TextField("imageURL", text: $imageURL)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .autocapitalization(.none)
                        
                        TextField("videoURL", text: $videoURL)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .autocapitalization(.none)
                        // Add similar input fields for other properties of `todo`
                        
                        Button(action: {
                            if isFormValid {
                                let db = Firestore.firestore()
                                let collectionRef = db.collection("exercises")
                                let documentID = UUID().uuidString
                                
                                let newExerciseData: [String: Any] = [
                                    "id": documentID,
                                    "name": name,
                                    "type": type,
                                    "muscle": muscle,
                                    "email": Email, //keeps unique to user
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
                                
                            }
                            else {
                                showAlert2 = true
                            }
                        }) {
                            Text("Add Exercise")
                            
                                .padding()
                            //                                .foregroundColor(.white)
                                .foregroundColor(.black)
                                .background(Color(hue: 0.527, saturation: 0.73, brightness: 0.848))
                                .cornerRadius(8)
                        
                        }
                    }
                    .padding()
                   
                    .alert(isPresented: $showAlert2) {
                                Alert(
                                    title: Text("Incomplete Form"),
                                    message: Text("Please fill in all the required fields."),
                                    dismissButton: .default(Text("OK")){
                                        showAlert2 = false
                                        showAlert = false
                                    }
                                )
                            }
                    .background(EmptyView().alert(isPresented: $showAlert) {
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
                    })
                }
            }
        }
    }
}
        
#Preview {
    AddExerciseView(Email: .constant("dnlonda@cougarnet.uh.edu"))
}
