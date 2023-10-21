//
//  HomeScreenView.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/12/23.
//

import SwiftUI

struct HomeScreenView: View {
    @ObservedObject var viewModel = ViewModel()
    @State private var searchTerm = ""
    var filteredTable: [Exercise] {
        guard !searchTerm.isEmpty else {return viewModel.exercise}
        return viewModel.exercise.filter {
            exercise in
            return exercise.name.description.localizedCaseInsensitiveContains(searchTerm) ||
                          exercise.type.localizedCaseInsensitiveContains(searchTerm) ||
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
                        .zIndex(0)
                        .frame(height: geoh * 0.1)
                    
                    VStack{
                        Text("")
                            .frame(height: 0)
                            .background(ignoresSafeAreaEdges: .all)
                        
                        
                        List{
                            Section( header: Text("Your Favorite Exercises")
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.black)){
                                    ForEach(filteredTable, id: \.name) { exercise in
                                        
                                        NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                                            HStack {
                                                
                                                AsyncImage(url:exercise.imageURL){
                                                    phase in
                                                    if let image = phase.image{
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: geow * 0.2, height: geoh * 0.11)
                                                    }
                                                }
                                                //                                Spacer()
                                                VStack {
                                                    Text(exercise.name).font(.title3).multilineTextAlignment(.leading)
                                                    HStack{
                                                        Image( "muscle_icon")
                                                            .resizable()
                                                            .frame(width: 30, height: 30)
                                                        
                                                        Text(exercise.muscle).font(.title3).multilineTextAlignment(.leading)
                                                        Image( exercise.difficulty == "beginner" ? "easy" : exercise.difficulty == "intermediate" ? "medium" : "hard")
                                                            .resizable()
                                                            .frame(width: 30, height: 30)
                                                        Text(exercise.difficulty).font(.title3).multilineTextAlignment(.leading)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .onDelete(perform: deleteExercise)
                                    .frame(height: geoh * 0.1)
                                    
                                    
                                    
                                    
                                    
                                }
                        }
                        
                        .searchable(text: $searchTerm, prompt:"Enter name, Type or muscle" )
                        .listStyle(InsetListStyle())
                        .onAppear {
                            viewModel.fetch()
                        }.navigationBarTitle("Generic Fitness App")
                        List{
                            Section(
                                header: Text("Your Favorite Foods")
                                    .font(.headline)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)){
                                        ForEach(filteredTable, id: \.name) { exercise in
                                            
                                            NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                                                HStack {
                                                    
                                                    AsyncImage(url:exercise.imageURL){
                                                        phase in
                                                        if let image = phase.image{
                                                            image
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: geow * 0.2, height: geoh * 0.11)
                                                        }
                                                    }
                                                    //                                Spacer()
                                                    VStack {
                                                        Text(exercise.name).font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/).multilineTextAlignment(.leading)
                                                        HStack{
                                                            Image( "muscle_icon")
                                                                .resizable()
                                                                .frame(width: 30, height: 30)
                                                            
                                                            Text(exercise.muscle).font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/).multilineTextAlignment(.leading)
                                                            Image( exercise.difficulty == "beginner" ? "easy" : exercise.difficulty == "intermediate" ? "medium" : "hard")
                                                                .resizable()
                                                                .frame(width: 30, height: 30)
                                                            Text(exercise.difficulty).font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/).multilineTextAlignment(.leading)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        .onDelete(perform: deleteExercise)
                                        .frame(height: geoh * 0.1)
                                        
                                        
                                        
                                        
                                        
                                    }}
                        
                        .searchable(text: $searchTerm, prompt:"Enter name, Type or muscle" )
                        .listStyle(InsetListStyle())
                        .onAppear {
                            viewModel.fetch()
                        }
                        //                    .navigationBarTitle("Your Favorite Food")
                        
                    }
                    //            .frame(height: geoh * 0.56)
                }.background(ignoresSafeAreaEdges: .all)
            }
        }
    }
        func deleteExercise(at offsets: IndexSet) {
        viewModel.exercise.remove(atOffsets: offsets)
    }
    
}
extension UIColor {
    convenience init(hex: Int) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

#Preview {
    HomeScreenView()
}
