//
//  testschedule.swift
//  Fitness Project
//
//  Created by Tran Phat on 11/26/23.
//

import SwiftUI

// Sample structure for Workout
struct Workout: Identifiable {
    let id = UUID()
    var title: String
    // Add other workout properties as needed
}

struct testschedule: View {
    @State var Sun: [[Workout]] = []
    
    var body: some View {
        VStack {
            Button("Generate Random Workouts") {
                assignRandomWorkouts()
            }
            .padding()
            
            List {
                ForEach(0..<Sun.count, id: \.self) { index in
                    VStack(alignment: .leading) {
                        Text("Set \(index + 1)")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                        
                        ForEach(Sun[index]) { workout in
                            HStack {
                                Text(workout.title)
                                    .padding()
                                    .background(Color.gray) // Set row background color
                                    .cornerRadius(8)
                                
                                Spacer()
                            }
                            .frame(height: 50) // Set row height
                            .padding(.vertical, 5)
                        }
                    }
                    .padding()
                    .background(Color.white) // Set list row color
                    .cornerRadius(10)
                    .shadow(radius: 3)
                    .padding(.vertical, 5)
                }
            }
        }
    }
    
    // Function to assign random workouts to Sun
    func assignRandomWorkouts() {
        let sampleWorkouts: [Workout] = [
            Workout(title: "Workout 1"),
            Workout(title: "Workout 2"),
            Workout(title: "Workout 3"),
            Workout(title: "Workout 4"),
            // Add more workouts as needed
        ]
        
        Sun.removeAll() // Clear previous data
        
        for _ in 0..<7 {
            let randomWorkouts = Array(sampleWorkouts.shuffled().prefix(2))
            Sun.append(randomWorkouts)
        }
    }
}




#Preview {
    testschedule()
}
