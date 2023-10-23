//
//  ExercisesView.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/22/23.
//

import SwiftUI

struct ExercisesView: View {
    @ObservedObject var viewModel = ViewModel()
    @State private var searchTerm = ""
    var filteredTable: [Exercise] {
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
                        //                        Text("")
                        //                            .frame(height: 0)
                        //                            .background(ignoresSafeAreaEdges: .all)
                        
                        
                        List{
                            Section( header: Text("Your Favorite Exercises")
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.black)){
                                    ForEach(filteredTable, id: \.name) { exercise in
                                        
                                        NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                                            HStack {
                                                
                                                
                                                
                                                AsyncImage(url: exercise.imageURL){
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
                                                            Image( "muscle_icon")
                                                                .resizable()
                                                                .frame(width: 30, height: 30)
                                                            
                                                            Text(exercise.muscle).font(.subheadline).multilineTextAlignment(.leading)
                                                                .frame(width: geow * 0.3)
                                                                .padding(.bottom)
                                                        }
                                                        VStack(alignment:.center,spacing:0){
                                                            Spacer()
                                                            Image( exercise.difficulty == "beginner" ? "easy" : exercise.difficulty == "intermediate" ? "medium" : "hard")
                                                                .resizable()
                                                                .frame(width: 30, height: 30)
                                                                .padding(.top)
                                                            Text(exercise.difficulty).font(.subheadline).multilineTextAlignment(.leading)
                                                                .padding(.bottom)
                                                                .padding(.bottom)
                                                            Spacer()
                                                        }.frame(width: geow * 0.3, height:geoh * 0.06)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .onDelete(perform: deleteExercise)
                                    .frame(height: geoh * 0.11)
                                    
                                    
                                    
                                    
                                    
                                }
                        }
                        
                        .searchable(text: $searchTerm, prompt:"Enter name, level of difficult or muscle" ){
                            
                            
                        } .background(Color(red: 0.625, green: 0.909, blue: 0.965))
                            .listStyle(InsetListStyle())
                            .onAppear {
                                viewModel.fetch()
                                
                            }.navigationBarTitle("Generic Fitness App", displayMode: .inline)
                            .background(Color.clear)
                    }
                    
                }
            }
        }
    }
    func deleteExercise(at offsets: IndexSet) {
        viewModel.exercise.remove(atOffsets: offsets)
    }
}
   
#Preview {
    ExercisesView()
}
