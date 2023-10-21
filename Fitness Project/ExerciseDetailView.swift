//
//  ExerciseDetailView.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/19/23.
//

import SwiftUI
import AVKit

struct ExerciseDetailView: View {
    let exercise: Exercise
    
    @State var videoID:String = ""
    
    var body: some View {
        ZStack{
//            Color.blue // Set the background color to blue
//                           .ignoresSafeArea()
        GeometryReader { geo in
           
                VStack {
                    VideoViews(videoID: exercise.videoURL)
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

#Preview {

    ContentView()
}

