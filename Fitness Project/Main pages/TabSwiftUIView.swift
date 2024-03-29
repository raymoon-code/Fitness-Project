//
//  TabSwiftUIView.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/22/23.
//

import SwiftUI

struct TabSwiftUIView: View {
    @Environment(\.verticalSizeClass) var heightSizeClass:UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthSizeClass:UserInterfaceSizeClass?
    @Binding var selectFeet: Int
    @Binding var selectInch: Int
    @Binding var selectlb: Int
    @Binding var Email: String
    var body: some View {
        if heightSizeClass == .regular {
            TabView {
                HomeScreenView(Email: $Email).tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                ExercisesView(Email: $Email).tabItem {
                    Image(systemName: "figure.run")
                    Text("Exercises")
                }
                FoodView(Email: $Email).tabItem {
                    Image(systemName: "fork.knife")
                    Text("Recipes")
                }
                WorkoutView( exercise: todo(id: String(), name: String(), email: String(), type: String(), muscle: String(), equipment: String(), difficulty: String(), instructions: String(), imageURL: String(), videoURL: String()), Email: $Email).tabItem{
                    Image(systemName: "figure.rower")
                    Text("Workouts")
                }
                DailyView(selectFeet: $selectFeet, selectInch: $selectInch, selectlb: $selectlb, Email: $Email).tabItem{
                    
                    Image(systemName: "calendar")
                    Text("Daily")
                }
                
            }
        } else if heightSizeClass == .compact {
            TabView {
                landscapehomeview(Email: $Email).tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                ExercisesView(Email: $Email).tabItem {
                    Image(systemName: "figure.run")
                    Text("Exercises")
                }
                FoodView(Email: $Email).tabItem {
                    Image(systemName: "fork.knife")
                    Text("Recipes")
                }
                WorkoutView( exercise: todo(id: String(), name: String(), email: String(), type: String(), muscle: String(), equipment: String(), difficulty: String(), instructions: String(), imageURL: String(), videoURL: String()), Email: $Email).tabItem{
                    Image(systemName: "figure.rower")
                    Text("Workouts")
                }
                landscapedailyview(selectFeet: $selectFeet, selectInch: $selectInch, selectlb: $selectlb, Email: $Email).tabItem{
                    
                    Image(systemName: "calendar")
                    Text("Daily")
                }
                
            }.background(.gray)
        }
        
    }
}

#Preview {
    TabSwiftUIView(selectFeet: .constant(5), selectInch: .constant(7), selectlb: .constant(148), Email: .constant("dnlonda@cougarnet.uh.edu"))
}
