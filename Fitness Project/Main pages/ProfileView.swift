//
//  ProfileView.swift
//  Fitness Project
//
//  Created by user236922 on 11/1/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

//@MainActor
//final class ProfileViewModel: ObservableObject {
    
    //@Published private(set) var user: AuthDataResultModel? = nil
    
    //func loadUser() throws{
        //self.user = try AuthenticationManager.shared.getAuthenticatedUser()
    //}
//}

struct ProfileView: View {
    
    @ObservedObject var viewModel = ViewModelUsers()
    //@Binding var searchTerm: String// change this to be the log in email.
    @Binding var searchTerm: String
    
    
    var filteredTable: [UserObj] {
        guard !searchTerm.isEmpty else {return viewModel.user}
        return viewModel.user.filter {
            exercise in
            return exercise.email.caseInsensitiveCompare(searchTerm) == ComparisonResult.orderedSame
        }
    }
    
    var body: some View {
        VStack{
            
            Text("Profile")
            ForEach(filteredTable){ user in

                List{
                    Text("Name: " + String(user.name))
                    Text("Email: " + String(user.email))
                    Text("Age: " + String(user.age))
                    Text("Current Weight: " + String(user.current_weight) + " pounds")
                    Text("Starting Weight: " + String(user.starting_weight) + " pounds")
                    HStack{
                        Text("Height: ")
                        Text(String(user.height_feet) + " Feet")
                        Text(String(user.height_inches) + " Inches")
                    }
                }
            }
            .onAppear{ // this works
                viewModel.getData()
            }
        }
    }
    
    init(searchTerm: Binding<String>){ //this works
        self._searchTerm = searchTerm
        viewModel.getData()
        //self.searchTerm = searchTerm
        //userViewModel.listenForChanges()
    }
    
    
}

#Preview {
    ProfileView(searchTerm: .constant("dnlonda@cougarnet.uh.edu"))
}


