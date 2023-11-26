//
//  AddWorkoutView.swift
//  Fitness Project
//
//  Created by Tran Phat on 11/26/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
struct AddWorkoutView: View {
    @ObservedObject var viewModel = ViewModelexercises()
    @State private var title = ""
    @State private var image = ""
    @State private var references = [String]()
    @State private var selectedExercises = [String]()
    @State private var showAlert = false
    @State private var showSuccessAlert = false

    var isFormValid: Bool {
        !title.isEmpty && !image.isEmpty && !references.isEmpty
    }

    var body: some View {
        VStack(spacing: 1) {
            TextField("Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Image URL", text: $image)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Text("References")
                .font(.headline)
                .padding()
            
            // TextFields for references...
            ForEach(0..<references.count, id: \.self) { index in
                HStack{
                    TextField("Reference \(index + 1)", text: $references[index])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        references.remove(at: index)
                    }) {
                        Image(systemName: "minus.circle")
                            .foregroundColor(.red)
                    }
                }
//                    .padding()
            }
//            SelectExerciseView(selectedExercises: $selectedExercises)
            GeometryReader { geo in
                let geow = geo.size.width
                let geoh = geo.size.height
                
            List(viewModel.exercise){ exercise in
                
                
                    HStack {
                        
                       Text("")
                           
                        
                        AsyncImage(url: URL(string:exercise.imageURL)!){
                            phase in
                            if let image = phase.image{
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geow * 0.18, height: geoh * 0.18)
                            }
                        }.padding()
                        Text("  ")
                        //                                Spacer()
                        VStack (spacing:0){
                            Text(exercise.name).font(.system(size: 20)).multilineTextAlignment(.center)
                                .frame(width: geow * 0.6, height: geoh * 0.04)
                                .fontWeight(.semibold)
                                .padding(.top)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                            HStack(spacing:1){
                                VStack(spacing:0){
                                    Image(exercise.muscle == "glutes" ? "glutes" : exercise.muscle == "full-body" || exercise.muscle == "whole body" ? "full_body" : exercise.muscle == "biceps" ? "Biceps 1" : exercise.muscle == "quadriceps" ? "Quadriceps" : exercise.muscle == "triceps" ? "Triceps 1" : exercise.muscle == "core" ? "lower-abs" : exercise.muscle == "flexibility" ? "flexibility" : "Chest1")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    
                                    Text(exercise.muscle.capitalized).font(.subheadline).multilineTextAlignment(.leading)
                                        .frame(width: geow * 0.3)
                                        .padding(.bottom)
                                }
                                VStack(alignment:.center,spacing:0){
                                    Spacer()
                                    Image( exercise.difficulty == "beginner" ? "easy" : exercise.difficulty == "intermediate" ? "medium" : "hard")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding(.top)
                                    Text(exercise.difficulty.capitalized).font(.subheadline).multilineTextAlignment(.leading)
                                        .padding(.bottom)
                                        .padding(.bottom)
                                    Spacer()
                                    
                                }.frame(width: geow * 0.25, height:geoh * 0.06)
                                    .offset(x:-20)
                                
                                Image(systemName: references.contains(exercise.id) ? "checkmark.diamond.fill" : "plus.circle.fill" )
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geow * 0.10, height:geoh * 0.16)
                                    .foregroundColor(references.contains(exercise.id) ? .gray : .green)
                                    .offset(x:-10, y:-10)
                                   
                                    .onTapGesture {
                                        if !references.contains(exercise.id) {
                                                                      references.append(exercise.id)
                                                                  }
                                        
                                    }
                            }
                        }
                    }
                
            }
            .listStyle(PlainListStyle())
//                                    .onDelete(perform: deleteExercise)
            .frame(width: geow,height: geoh * 0.91)
                
            }
            Button(action: {
                if isFormValid {
                    submitForm()
                    addWorkout()
                    title = ""
                    image = ""
                    references = []
                } else {
                    showAlert = true // Show the incomplete form alert
                }
            }) {
                Text("Add Workout")
                    .padding()
                    .foregroundColor(.white)
                    .background(isFormValid ? Color.blue : Color.gray)
                    .cornerRadius(8)
                    .opacity(isFormValid ? 1.0 : 0.5)
                    .disabled(!isFormValid)
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Incomplete Form"),
                    message: Text("Please fill in all the required fields."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .background(
                EmptyView().alert(isPresented: $showSuccessAlert) {
                    Alert(
                        title: Text("Success"),
                        message: Text("Workout added successfully!"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            )
        }
        .padding(1)
    }
    init(){
        viewModel.getData()
        viewModel.listenForChanges()
    }
    func submitForm() {
        // Handle the form submission or other actions
        // For demonstration purposes, just toggling success alert
        showSuccessAlert = true
    }
    func addWorkout() {
        let db = Firestore.firestore()
        let collectionRef = db.collection("workouts")
        let documentID = UUID().uuidString
        
        // Prepare data for the new food item
        let newWorkoutData: [String: Any] = [
            "id": documentID,
            "image": image,
            "ref1": references ,
            "title": title
            
        ]
        
        collectionRef.document(documentID).setData(newWorkoutData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully with ID: \(documentID)")
                showAlert = true
            }
        }
    }
}


#Preview {
    AddWorkoutView()
}
