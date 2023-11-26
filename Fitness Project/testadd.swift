//
//  testadd.swift
//  Fitness Project
//
//  Created by Tran Phat on 11/25/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct testadd: View {
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
//                       .onTapGesture {
//                           showAlert.toggle()
//                       }
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
               })
                  }
       }
   }

#Preview {
    testadd()
}
