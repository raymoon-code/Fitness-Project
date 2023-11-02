//
//  ProfileView.swift
//  Fitness Project
//
//  Created by user236922 on 11/1/23.
//

import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: AuthDataResultModel? = nil
    
    func loadUser() throws{
        self.user = try AuthenticationManager.shared.getAuthenticatedUser()
    }
}

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    @State var profile: Profiles
    
    @ObservedObject var viewModel4 = ViewModel4()
    
    var body: some View {
        VStack{
            if let user = viewModel.user{
                Text("userid: \(user.uid)")
            }
            Text("Profile")
            Text("Name: " + profile.firstName  + " " + profile.lastName)
            Text("Age: " + String(profile.age))
            Text("Starting Weight: " + String(profile.startingWeight) + " pounds")
            Text("Current Weight: " + String(profile.currentWeight) + " pounds")
            
            Text( profile.startingWeight > profile.currentWeight ? ("You have lost " + String(profile.startingWeight - profile.currentWeight)) : ("You have gained " + String(profile.currentWeight - profile.startingWeight)))
        }
        .onAppear {
            try? viewModel.loadUser()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(
            profile: Profiles(
                profileID: 1,
                firstName: "Daniel",
                lastName: "londa",
                age: 21,
                email: "dnlonda@cougarnet.uh.edu",
                password: "password",
                startingWeight: 175,
                currentWeight: 165
            )
        )
    }
}

