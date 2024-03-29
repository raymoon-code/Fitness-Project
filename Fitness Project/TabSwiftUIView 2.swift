//
//  TabSwiftUIView.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/22/23.
//

import SwiftUI

struct TabSwiftUIView: View {
    var body: some View {
        TabView {
            HomeScreenView().tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            ExercisesView().tabItem {
                Image(systemName: "figure.run")
                Text("Exercises")
            }
            FoodView().tabItem {
                Image(systemName: "fork.knife")
                Text("Recipes")
            }
            WorkoutView().tabItem{
                Image(systemName: "circle")
                Text("Workouts")
            }
            DailyView().tabItem{
                
                Image(systemName: "calendar")
                Text("Daily")
            }
        }
        
    }
}

#Preview {
    TabSwiftUIView()
}
