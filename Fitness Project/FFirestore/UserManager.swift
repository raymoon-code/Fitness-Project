//
//  UserManager.swift
//  Fitness Project
//
//  Created by user236922 on 11/2/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager{
    
    static let shared = UserManager()
    private init() { }
    
    func createNewUser(auth: AuthDataResultModel) async throws{
        
        var userData: [String: Any] = [
            "uid": auth.uid,
            "email": auth.email ?? "",
            
        ]
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
    
}
