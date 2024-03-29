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
    var imageURL:URL
    let videoURL:String
}

class ViewModel: ObservableObject {
    
    @Published var exercise: [Exercise] = []
    func fetch() {
        guard let url = URL(string:"https://www.jsonkeeper.com/b/M1TC") else {return}
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

struct Foods: Hashable, Codable {
    let name: String
    let minute:Int
    let kcal:Int
    let carbs:Int
    let fat:Int
    let protein:Int
    let ingredients:[String]
    let directions:[String]
    let imageURL:URL
}

class ViewModel2: ObservableObject {
    
    @Published var food: [Foods] = []
    func fetch() {
        guard let url = URL(string:"https://www.jsonkeeper.com/b/SM04") else {return}
        let task = URLSession.shared.dataTask(with:url) {[weak self]
            data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let food = try JSONDecoder().decode([Foods].self, from: data)
                DispatchQueue.main.async {
                   
                    self?.food = food
                    print(food)
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}


struct Workouts: Hashable, Codable {
    let title: String
    let exercises: [Exercise]
    let image: URL
}

class ViewModel3: ObservableObject{
    @Published var workout: [Workouts] = []
    
    //https://www.jsonkeeper.com/b/X613
    
    func fetch() {
        guard let url = URL(string:"https://www.jsonkeeper.com/b/SUZB") else {return}
        let task = URLSession.shared.dataTask(with:url) {[weak self]
            data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let workout = try JSONDecoder().decode([Workouts].self, from: data)
                DispatchQueue.main.async {
                    self?.workout = workout
                }
            }
            catch {
               
            }
        }
        task.resume()
    }

}
