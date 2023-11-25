//
//  ExercisesView.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/22/23.
//

import SwiftUI

import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

struct ExercisesView: View {
    @ObservedObject var viewModel = ViewModelexercises()
    @State private var searchTerm = ""
    var filteredTable: [todo] {
        guard !searchTerm.isEmpty else {return viewModel.exercise}
        return viewModel.exercise.filter {
            exercise in
            return exercise.name.description.localizedCaseInsensitiveContains(searchTerm) ||
            exercise.difficulty.localizedCaseInsensitiveContains(searchTerm) ||
            exercise.muscle.localizedCaseInsensitiveContains(searchTerm)
        }
        
    }
    var body: some View {
        GeometryReader { geo in
            let geow = geo.size.width
            let geoh = geo.size.height
            NavigationView {
                
                ZStack(alignment: .top){
                    
                    Rectangle()
                        .background(Color(red: 0.625, green: 0.909, blue: 0.965))
                        .zIndex(1)
                        .frame(height: geoh * 0.0001)
                    
                    VStack{
                        
                        List{
                            Section( header: Text("Your Favorite Exercises")
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.black)){
                                    ForEach(filteredTable) { exercise in
                                        
                                        NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                                            HStack {
                                                
                                               Text("")
                                                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                                        Button("delete"){
                                                            viewModel.deleteExercise(exercise) { success in
                                                                                                if success {
                                                                                                    print("Exercise deleted successfully")
                                                                                                } else {
                                                                                                    print("Failed to delete exercise")
                                                                                                }
                                                                                            }
                                                        }.tint(.red)
                                                    }
                                                
                                                AsyncImage(url: URL(string:exercise.imageURL)!){
                                                    phase in
                                                    if let image = phase.image{
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: geow * 0.1, height: geoh * 0.1)
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
                                                        }.frame(width: geow * 0.3, height:geoh * 0.06)
                                                    }
                                                }
                                            }
                                        }
                                    }
//                                    .onDelete(perform: deleteExercise)
                                    .frame(height: geoh * 0.11)
                                    
                                    
                                    
                                    
                                    
                                }
                            // Button to navigate to the AddExerciseView
                                       
                        }
                        
                        
//
                       
                        .searchable(text: $searchTerm, prompt:"Enter name, level of difficulty or muscle" ){
                            
                            
                        } .background(Color(red: 0.625, green: 0.909, blue: 0.965))
                            .listStyle(InsetListStyle())
//                            .onAppear {
//                                viewModel.getData()
//                                
//                            }
                            .navigationBarTitle("Generic Fitness App", displayMode: .inline)
                            .background(Color.clear)
                        NavigationLink(destination: AddExerciseView()) {
                            Text("Add New Exercise")
                                .font(.headline)
                                .padding()
                                .foregroundColor(.black)
                                .background(Color(hue: 0.527, saturation: 0.73, brightness: 0.848))
                                .cornerRadius(8)
                        }.navigationViewStyle(StackNavigationViewStyle())
                        .padding()
                    } 
                    
                    
                }
            }
        }
    }
    
    init(){
        viewModel.getData()
        viewModel.listenForChanges()
    }
//    func deleteExercises(at offsets: IndexSet) {
//        for index in offsets {
//            let exercise = filteredTable[index]
//            
//            viewModel.deleteExercise(exercise) { success in
//                if success {
//                    // Exercise deleted successfully
//                } else {
//                    // Failed to delete exercise
//                }
//            }
//        }
//    }
    func deleteExercise(at offsets: IndexSet) {
        viewModel.exercise.remove(atOffsets: offsets)
    }
}
   
#Preview {
    ExercisesView()
}
