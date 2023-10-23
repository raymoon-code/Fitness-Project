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
           
                VStack {
                    VideoViews(exercise: $exercise, videoID: exercise.videoURL)
                        .frame(height: geo.size.height * 0.4)
                    VStack{
                        Text("Instructions:")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text(exercise.instructions)
                        Text("Target Muscle:")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text(exercise.muscle)
                    } .frame(height: geo.size.height * 0.4)
                   Spacer()
                }.frame(height: geo.size.height)
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
                        Text("Instructions:")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text(food.directions)
                        Text("Target Muscle:")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        ForEach(food.ingredients, id: \.self) { food in
                            Text("-" + food)
                        }
                        
                    } .frame(width: geow * 0.8 ,height: geo.size.height * 0.8)
                   Spacer()
                }
            }
        }
//        .background(.blue)
        }
    }
}

#Preview {

    ContentView()
}

