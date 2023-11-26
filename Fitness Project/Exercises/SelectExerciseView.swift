//
//  SelectExerciseView.swift
//  Fitness Project
//
//  Created by Tran Phat on 11/26/23.
//

import SwiftUI

struct SelectExerciseView: View {
    @Binding var selectedExercises: [String]
    @State private var isSelectid = [String]()
    @ObservedObject var viewModel = ViewModelexercisesforworkout()
    @State private var searchTerm = ""
    var filteredTable: [exer] {
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
                                    ForEach(viewModel.exercise.indices, id: \.self) { index in
                                        let exercise = viewModel.exercise[index]
                                        
//                                        NavigationLink(destination: testexer(exercise: exercise)) {
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
                                                        Button(action: {
                                                                    viewModel.exercise[index].isSelected.toggle()
                                                                    if viewModel.exercise[index].isSelected {
                                                                        selectedExercises.append(viewModel.exercise[index].id)
                                                                    } 
//                                                            else {
//                                                                        if let indexToRemove = selectedExercises.firstIndex(of: viewModel.exercise[index].id) {
//                                                                            selectedExercises.remove(at: indexToRemove)
//                                                                        }
//                                                                    }
                                                                }) {
                                                                    Image(systemName: viewModel.exercise[index].isSelected ? "checkmark.square.fill" : "square")
                                                                        .resizable()
                                                                        .frame(width: 20, height: 20)
                                                                        .foregroundColor(viewModel.exercise[index].isSelected ? .blue : .gray)
                                                                }.zIndex(1)
                                                       
                                                    }
//                                                }
                                            }
                                        }
                                    }
//                                    .onDelete(perform: deleteExercise)
                                    .frame(height: geoh * 0.11)
                                    
                                    
                                    
                                    
                                    
                                }
                            // Button to navigate to the AddExerciseView
                            
                                       
                        }
                        
                        
//
                       
//                        .searchable(text: $searchTerm, prompt:"Enter name, level of difficulty or muscle" ){
//                            
//                            
//                        } 
                        .background(Color(red: 0.625, green: 0.909, blue: 0.965))
                            .listStyle(InsetListStyle())
                            .onAppear {
                                viewModel.getData()
//                                viewModel.listenForChanges()

                            }
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
    SelectExerciseView(selectedExercises: .constant(["KrJWydOkq5BuGUVnT4nk"]))
}
