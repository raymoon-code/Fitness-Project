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
    @Binding var Email: String
    var body: some View {
        
        TabView {
            HomeScreenView(Email: $Email).tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            ExercisesView( Email: $Email).tabItem {
                Image(systemName: "figure.run")
                Text("Exercises")
            }
            FoodView().tabItem {
                Image(systemName: "fork.knife")
                Text("Recipes")
            }
            WorkoutView( exercise: todo(id: String(), name: String(), email: String(), type: String(), muscle: String(), equipment: String(), difficulty: String(), instructions: String(), imageURL: String(), videoURL: String())).tabItem{
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
    TabSwiftUIView(selectFeet: .constant(5), selectInch: .constant(7), selectlb: .constant(148), Email: .constant("dnlonda@cougarnet.uh.edu"))
}
