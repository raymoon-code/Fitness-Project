//
//  model.swift
//  Fitness Project
//
//  Created by Tran Phat on 11/8/23.
//

import Foundation

struct todos: Identifiable {
    var id: String
    var name: String
    
}

struct wout: Identifiable, Codable {
    var id: String
    var title: String
    var email: String
    var image: String
    var ref1: [String]
    

}

