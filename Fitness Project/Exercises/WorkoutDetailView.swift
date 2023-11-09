//
//  WorkoutDetailView.swift
//  Fitness Project
//
//  Created by user236922 on 10/26/23.
//

import SwiftUI

struct WorkoutDetailView: View {
    
    @State var workout: wout
    
    @ObservedObject var viewModel3 = ViewModel3()
    
    @State private var searchTerm = ""
    
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
                            Section( header: Text(workout.title)
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.black)){
//                                    ForEach(workout.exercises, id: \.name) { exercise in
//                                        
//                                        NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
//                                            HStack {
//                                                
//                                                
//                                                
//                                                AsyncImage(url: URL(string:exercise.imageURL)){
//                                                    phase in
//                                                    if let image = phase.image{
//                                                        image
//                                                            .resizable()
//                                                            .aspectRatio(contentMode: .fill)
//                                                            .frame(width: geow * 0.1, height: geoh * 0.1)
//                                                    }
//                                                }.padding()
//                                                Text("  ")
//                                                //                                Spacer()
//                                                VStack (spacing:0){
//                                                    Text(exercise.name).font(.system(size: 20)).multilineTextAlignment(.center)
//                                                        .frame(width: geow * 0.6, height: geoh * 0.04)
//                                                        .fontWeight(.semibold)
//                                                        .padding(.top)
//                                                        .lineLimit(1)
//                                                        .minimumScaleFactor(0.5)
//                                                    HStack(spacing:1){
//                                                        VStack(spacing:0){
//                                                            Image(exercise.muscle == "glutes" ? "glutes" : exercise.muscle == "full-body" || exercise.muscle == "whole body" ? "full_body" : exercise.muscle == "biceps" ? "Biceps 1" : exercise.muscle == "quadriceps" ? "Quadriceps" : exercise.muscle == "triceps" ? "Triceps 1" : exercise.muscle == "core" ? "lower-abs" : exercise.muscle == "flexibility" ? "flexibility" : "Chest1")
//                                                                .resizable()
//                                                                .frame(width: 30, height: 30)
//                                                            
//                                                            Text(exercise.muscle.capitalized).font(.subheadline).multilineTextAlignment(.leading)
//                                                                .frame(width: geow * 0.3)
//                                                                .padding(.bottom)
//                                                        }
//                                                        VStack(alignment:.center,spacing:0){
//                                                            Spacer()
//                                                            Image( exercise.difficulty == "beginner" ? "easy" : exercise.difficulty == "intermediate" ? "medium" : "hard")
//                                                                .resizable()
//                                                                .frame(width: 30, height: 30)
//                                                                .padding(.top)
//                                                            Text(exercise.difficulty.capitalized).font(.subheadline).multilineTextAlignment(.leading)
//                                                                .padding(.bottom)
//                                                                .padding(.bottom)
//                                                            Spacer()
//                                                        }.frame(width: geow * 0.3, height:geoh * 0.06)
//                                                    }
//                                                }
//                                            }
//                                        }
//                                    }
                                    //.onDelete(perform: deleteExercise)
//                                    .frame(height: geoh * 0.11)
                                    
                                    
                                    
                                    
                                    
                                }
                        }
                        
                        .searchable(text: $searchTerm, prompt:"Search Exercises" ){
                            
                            
                        } .background(Color(red: 0.625, green: 0.909, blue: 0.965))
                            .listStyle(InsetListStyle())
                            .onAppear {
                                
                                viewModel3.fetch()
                            }.navigationBarTitle("Generic Fitness App", displayMode: .inline)
                            .background(Color.clear)
                    }
                    
                }
            }
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workout: wout(
            id: "1", title: "Default Workout 1",
//            exercises: [
//                todo(
//                    id: "a", name: "Barbell Glute Bridge",
//                                  type: "Strength",
//                                   muscle: "Glutes",
//                                   equipment: "Barbell",
//                                   difficulty: "beginner",
//                                   instructions: "4 sets of 15 reps. Rest 45 sec between sets.",
//                            imageURL: "https://img.youtube.com/vi/FMyg_gsA0mI/1.jpg",
//                            videoURL: "https://www.youtube.com/watch?v=FMyg_gsA0mI&ab_channel=GirlsGoneStrong")
//            ],
            image:  "https://lastcallattheoasis.com/wp-content/uploads/2020/06/vegetable_stir_fry.jpg", ref1: "2EYR6xL7jULX1WxHrIBj"
        ))
    }
}
