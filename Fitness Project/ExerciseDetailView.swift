//
//  ExerciseDetailView.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/19/23.
//

import SwiftUI
import AVKit

struct ExerciseDetailView: View {
    @State var exercise: Exercise
    
    @State var videoID:String = ""
    
    var body: some View {
        ZStack{
            //            Color.blue // Set the background color to blue
            //                           .ignoresSafeArea()
            GeometryReader { geo in
                
                ScrollView {
                    VStack (alignment:.center){
                        VideoViews(exercise: $exercise, videoID: exercise.videoURL)
                            .frame(height: geo.size.height * 0.4)
                        var imagesize:Double  = 50.0
                        VStack{
                            Text(exercise.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            HStack {
                                Spacer()
                                VStack(spacing:0){
//                                    Text("Target Muscle")
//                                        .padding(2)
//                                        .font(.title2)
//                                        .fontWeight(.medium)
                                    Image( "muscle_icon")
                                        .resizable()
                                        .foregroundColor(Color(hue: 0.161, saturation: 0.975, brightness: 0.98))
                                        .frame(width: imagesize, height: imagesize)
                                    Text(exercise.muscle)
                                }
                                Spacer()
                                VStack (spacing:0){
//                                    Text("difficulty level")
//                                        .padding(2)
//                                        .font(.title2)
//                                        .fontWeight(.medium)
                                    Image( exercise.difficulty == "beginner" ? "easy" : exercise.difficulty == "intermediate" ? "medium" : "hard")
                                        .resizable()
                                        .frame(width: imagesize, height: imagesize)
                                        
                                    Text(exercise.difficulty)
                                   
                                }
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                VStack(spacing:0){
//                                    Text("equipment")
//                                        .padding(2)
//                                        .font(.title2)
//                                        .fontWeight(.medium)
                                    Image(systemName:  "dumbbell.fill")
                                        .resizable()
                                        .foregroundColor(Color(hue: 0.999, saturation: 0.978, brightness: 0.97, opacity: 0.727))
                                        .frame(width: imagesize, height: imagesize)
                                    Text(exercise.equipment)
                                }
                                Spacer()
                                VStack (spacing:0){
//                                    Text("Type")
//                                        .padding(2)
//                                        .font(.title2)
//                                        .fontWeight(.medium)
                                    Image(systemName: "figure.run.square.stack")
                                        
                                        .resizable()
                                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                        .frame(width: imagesize, height: imagesize)
                                        
                                    Text(exercise.type)
                                   
                                }
                                Spacer()
                            }
                            
                                
                            
                            
                               
                            
                            
                            
                            Text("Instructions:")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text(exercise.instructions)
                            
                            
                        } .frame(height: geo.size.height * 0.5)
                        Spacer()
                    }.frame(height: geo.size.height)
                }
            }
        }
//        .background(.blue)
        
    }
}

struct ExerciseDetailView2: View {
    @State var food: Foods
    
    @State var videoID:String = ""
    
    var body: some View {
       
        ZStack(alignment:.top){
            
//            Color.blue // Set the background color to blue
//                           .ignoresSafeArea()
        GeometryReader { geo in
            ScrollView {
                
            
            let geow = geo.size.width
            let geoh = geo.size.height
                VStack (alignment: .center){
                    
                    AsyncImage(url:food.imageURL){
                        phase in
                        if let image = phase.image{
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geow , height: geoh * 0.5)
                        }
                    }
                       
                    VStack{
                        Text(food.name)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .padding(1)
                        HStack{
                            Spacer()
                            Image(systemName: "timer")
                            
                                .foregroundColor(Color.pink)
                            Text("\(food.minute) minutes")
                            Spacer()
                            Image(systemName: "flame")
                                .foregroundColor(Color.pink)
                            Text("\(food.kcal) kcal")
                            Spacer()
                        }
                        HStack{
                            ZStack{
                                VStack{
                                    Text("CARBS")
                                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                                    Text("\(food.carbs)g")
                                        .fontWeight(.heavy)
                                        
                                }.font(.footnote).frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .multilineTextAlignment(.center)
                                Circle()
                                    .frame(width: 70)
                                    .foregroundColor(.pink)
                                    .opacity(0.4)
                                    
                                
                            }
                            ZStack{
                                VStack{
                                    Text("FAT")
                                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                                    Text("\(food.fat)g")
                                        .fontWeight(.heavy)
                                        
                                }.font(.footnote).frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .multilineTextAlignment(.center)
                                Circle()
                                    .frame(width: 70)
                                    .foregroundColor(.green)
                                    .opacity(0.4)
                                    
                                
                            }
                            ZStack{
                                VStack{
                                    Text("PROTEIN")
                                        
                                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                                    Text("\(food.protein)g")
                                        .fontWeight(.heavy)
                                        
                                }.font(.footnote)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .multilineTextAlignment(.center)
                                Circle()
                                    .frame(width: 70)
                                    .foregroundColor(.yellow)
                                    .opacity(0.4)
                                    
                                
                            }
                        }
                        Text("ingredients:")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        ForEach(food.ingredients, id: \.self) { food in
                            HStack{
//                                Text("- ")
                                Circle()
                                    .frame(width: 7)
                                    .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0)/*@END_MENU_TOKEN@*/)
                                Text(food)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                           
                        }
                        Text("Directions:")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        ForEach(Array(food.directions.enumerated()), id: \.offset) { index,step in
                            VStack(spacing:0){
                                ZStack{
                                    Circle()
                                        .frame(width: 70)
                                        .foregroundColor(.yellow)
                                    Text("\(index + 1)")
                                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                }
                                Text(step)
                                    .font(.title3)
                                    .fontWeight(.heavy)
                                    .lineLimit(nil)
                                    .frame(height: geoh * 0.08)
                            }
                            
                        }.frame(height: geoh * 0.15)
                        
                        
                    } .frame(width: geow * 0.8 ,height: geo.size.height * 1.7)
                   Spacer()
                }
            }
        }
//        .background(.blue)
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
        ExerciseDetailView(exercise: Exercise(
            name: "Barbell Glute Bridge",
                   type: "strength",
                   muscle: "glutes",
                   equipment: "barbell",
                   difficulty: "beginner",
                   instructions: "4 sets of 15 reps. Rest 45 sec between sets.",
            imageURL: URL(string: "https://img.youtube.com/vi/FMyg_gsA0mI/1.jpg")!,
                   videoURL: "https://www.youtube.com/watch?v=FMyg_gsA0mI&ab_channel=GirlsGoneStrong"))
    }
}
