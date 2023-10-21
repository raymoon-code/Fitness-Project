//
//  ViewModel.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/19/23.
//

import Foundation
import SwiftUI

struct Exercise: Hashable, Codable {
    let name: String
    let type:String
    let muscle:String
    let equipment:String
    let difficulty:String
    let instructions:String
    let imageURL:URL
    let videoURL:String
}

class ViewModel: ObservableObject {
    
    @Published var exercise: [Exercise] = []
    func fetch() {
        guard let url = URL(string:"https://www.jsonkeeper.com/b/B7OO") else {return}
        let task = URLSession.shared.dataTask(with:url) {[weak self]
            data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let exercise = try JSONDecoder().decode([Exercise].self, from: data)
                DispatchQueue.main.async {
                   
                    self?.exercise = exercise
                    print(exercise)
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}
