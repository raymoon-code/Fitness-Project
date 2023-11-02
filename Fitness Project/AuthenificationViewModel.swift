//
//  AuthenificationViewModel.swift
//  Fitness Project
//
//  Created by user236922 on 11/2/23.
//

import Foundation

@MainActor
final class AuthenificationViewModel: ObservableObject {
    func signInAnonymous() async throws{
        let authDataResult = try await AuthenticationManager.shared.signInUser(email: "A", password: "A")
    }
}
