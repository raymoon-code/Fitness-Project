//
//  ProfileView.swift
//  Fitness Project
//
//  Created by user236922 on 11/1/23.
//

import SwiftUI

struct ProfileView: View {
    
    @State var profile: Profiles
    
    @ObservedObject var viewModel4 = ViewModel4()
    
    var body: some View {
        VStack{
            Text("Profile")
            Text("Name: " + profile.firstName + " " + profile.lastName)
            Text("Age: " + String(profile.age))
            Text("Starting Weight: " + String(profile.startingWeight) + " pounds")
            Text("Current Weight: " + String(profile.currentWeight) + " pounds")
            
            Text( profile.startingWeight > profile.currentWeight ? ("You have lost " + String(profile.startingWeight - profile.currentWeight)) : ("You have gained " + String(profile.currentWeight - profile.startingWeight)))
        }
        .onAppear {
            viewModel4.fetch()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(
            profile: Profiles(
                firstName: "Daniel",
                lastName: "londa",
                age: 21,
                startingWeight: 175,
                currentWeight: 165
            )
                
                
        )
    }
}

