//
//  ExerciseDetailView.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/19/23.
//

import SwiftUI
import AVKit

struct ExerciseDetailView: View {
    @State var exercise: todo
    
    @State var videoID:String = ""
    
    var body: some View {
        ZStack(alignment:.top){
            //            Color.blue // Set the background color to blue
            //                           .ignoresSafeArea()
            GeometryReader { geo in
                let geow = geo.size.width
                let geoh = geo.size.height
                
                let iconHeight = geoh * 0.04
                let iconWidth = geow * 0.1
                VStack (alignment:.center){
                    ScrollView {
                        VideoViews(exercise: $exercise, videoID: exercise.videoURL)
                            .frame(height: geo.size.height * 0.4)
                        
                        //VStack{
                        
                        Text(exercise.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        HStack{
                            Spacer()
                            VStack{
                                Spacer()
                                VStack(alignment:.center){
                                    Text("Target Muscles")
                                        .fontWeight(.bold)
                                    Text(exercise.muscle.capitalized)
                                    Image(exercise.muscle == "Glutes" ? "glutes" : exercise.muscle == "full-body" || exercise.muscle == "whole body" ? "full_body" : exercise.muscle == "biceps" ? "Biceps 1" : exercise.muscle == "quadriceps" ? "Quadriceps" : exercise.muscle == "triceps" ? "Triceps 1" : exercise.muscle == "core" ? "lower-abs" : exercise.muscle == "flexibility" ? "flexibility" : "Chest1")
                                        .resizable()
                                        .foregroundColor(Color(hue: 0.161, saturation: 0.975, brightness: 0.98))
                                        .frame(width: iconWidth, height: iconHeight)
                                    
                                }
                                .frame(maxHeight: geoh * 0.15)
                                Spacer()
                                VStack (spacing:0){
                                    Text("Difficulty")
                                        .fontWeight(.bold)
                                    Text(exercise.difficulty.capitalized)
                                    
                                    Image( exercise.difficulty == "beginner" ? "easy" : exercise.difficulty == "intermediate" ? "medium" : "hard")
                                        .resizable()
                                        .frame(width: iconWidth, height: iconHeight)
                                    
                                }
                                .frame(maxHeight: geoh * 0.15)
                                Spacer()
                            }
                            
                            Spacer()
                            VStack {
                                Spacer()
                                VStack(spacing:0){
                                    Text("Equipment")
                                        .fontWeight(.bold)
                                    Text(exercise.equipment.capitalized)
                                    Image(systemName:  "dumbbell.fill")
                                        .resizable()
                                        .foregroundColor(Color(hue: 0.999, saturation: 0.978, brightness: 0.97, opacity: 0.727))
                                        .frame(width: iconWidth, height: iconHeight)
                                    
                                }
                                .frame(maxHeight: geoh * 0.15)
                                Spacer()
                                VStack (spacing:0){
                                    Text("Type")
                                        .fontWeight(.bold)
                                    Text(exercise.type.capitalized)
                                    Image(systemName: "figure.run.square.stack")
                                    
                                        .resizable()
                                        .foregroundColor(.blue)
                                        .frame(width: iconWidth , height: iconHeight)
                                    
                                }
                                .frame(maxHeight: geoh * 0.15)
                                Spacer()
                            }
                            .frame(maxHeight: geoh * 0.1)

                            Spacer()
                        }
                        

                        Text("Recommendations:")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        Text(exercise.instructions)
                            .multilineTextAlignment(.center)
                        
                        VStack{
                            Text("Instructions")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.top)
                            Text(exercise.instructions)
                                .multilineTextAlignment(.center)
//                            Text("1. Lay down with a barbell across your hips")
//                                .multilineTextAlignment(.center)
//                            Text("2. Raise your knees and plant your feet")
//                                .multilineTextAlignment(.center)
//                            
//                            Text("3. With your shoulder blades on the ground")
//                                .multilineTextAlignment(.center)
//                            Text("4. Thrust your hips upward")
                            
                        }
                    //} .frame(height: geo.size.height * 0.5)
                    
                }.frame(height: geo.size.height)
                Spacer()
            }
            
        }
        }
    }
}

//#Preview {
//
//    ContentView()
//}

struct ExerciseDetailView2_Previews: PreviewProvider {
    static var previews: some View {
//        ExerciseDetailView2(food: Foods(
//            name: "Vegetable Stir-Fry",
//            minute: 15,
//            kcal: 250,
//            carbs: 30,
//            fat: 8,
//            protein: 12,
//            ingredients: [
//                "Broccoli",
//                "Bell peppers",
//                "Carrots",
//                "Snap peas",
//                "Soy sauce",
//                "Sesame oil",
//                "Garlic",
//                "Ginger",
//                "Rice"
//            ],
//            directions: [
//                "Chop vegetables into bite-sized pieces.",
//                "Heat sesame oil in a pan and add garlic and ginger.",
//                "Stir-fry vegetables until tender.",
//                "Add soy sauce.",
//                "Serve over cooked rice."
//            ],
//            imageURL: URL(string: "https://lastcallattheoasis.com/wp-content/uploads/2020/06/vegetable_stir_fry.jpg")!
//        ))
ExerciseDetailView(exercise: todo(
    id: "1", name: "Barbell Glute Bridge",
                  type: "Strength",
                   muscle: "Glutes",
                   equipment: "Barbell",
                   difficulty: "beginner",
                   instructions: "4 sets of 15 reps. Rest 45 sec between sets.",
            imageURL: "https://img.youtube.com/vi/FMyg_gsA0mI/1.jpg",
                   videoURL: "https://www.youtube.com/watch?v=FMyg_gsA0mI&ab_channel=GirlsGoneStrong")
)
    }
}
