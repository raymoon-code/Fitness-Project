//
//  TabSwiftUIView.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/22/23.
//

import SwiftUI

struct TabSwiftUIView: View {
    @Binding var selectFeet: Int
    @Binding var selectInch: Int
    @Binding var selectlb: Int
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
            DailyView(selectFeet: $selectFeet, selectInch: $selectInch, selectlb: $selectlb).tabItem{
                
                Image(systemName: "calendar")
                Text("Daily")
            }
        }
        
    }
}

#Preview {
    TabSwiftUIView(selectFeet: .constant(5), selectInch: .constant(7), selectlb: .constant(148))
}
