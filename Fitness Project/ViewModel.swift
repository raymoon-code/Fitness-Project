//
//  ViewModel.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/19/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseDatabaseSwift
import FirebaseFirestore
import FirebaseFirestoreSwift

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

struct todo: Identifiable {
    
    var id: String
    var name: String
    var type:String
    var muscle:String
    var equipment:String
    var difficulty:String
    var instructions:String
    var imageURL:String
    var videoURL:String
}
struct testtodo: Identifiable {
    var id: String
    var name: String
    
}

class ViewModelexercises: ObservableObject {
    
    @Published var exercise = [todo]()
    @Published var exercisebyid = todo(id: String(), name: String(), type: String(), muscle: String(), equipment: String(), difficulty: String(), instructions: String(), imageURL: String(), videoURL: String())
    func getData(){
        let db = Firestore.firestore()
        db.collection("exercises").getDocuments{ snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.exercise = snapshot.documents.map { d in
                            return todo( id:d.documentID, name: d["name"] as? String ?? "",
                                             type: d["type"] as? String ?? "",
                                             muscle: d["muscle"] as? String ?? "",
                                             equipment: d["equipment"] as? String ?? "",
                                             difficulty: d["difficulty"] as? String ?? "",
                                             instructions: d["instructions"] as? String ?? "",
                                             imageURL: (d["imageURL"] as? String ?? ""),
                                             videoURL: d["videoURL"] as? String ?? "")
                        }
                    }
                    
                   
                }
            } else {
                return print("error")
            }
        }
    }
    func getExerciseByID(documentID: String) {
        let db = Firestore.firestore()
        let exerciseRef = db.collection("exercises").document(documentID)
        
        exerciseRef.getDocument { document, error in
            if let error = error {
                print("Error getting document by ID: \(error)")
            } else if let document = document, document.exists {
                DispatchQueue.main.async {
                    let data = document.data() ?? [:]
                    self.exercisebyid =
                        todo(
                            id: document.documentID,
                            name: data["name"] as? String ?? "",
                            type: data["type"] as? String ?? "",
                            muscle: data["muscle"] as? String ?? "",
                            equipment: data["equipment"] as? String ?? "",
                            difficulty: data["difficulty"] as? String ?? "",
                            instructions: data["instructions"] as? String ?? "",
                            imageURL: data["imageURL"] as? String ?? "",
                            videoURL: data["videoURL"] as? String ?? ""
                        )
                    
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
}





class ViewModeltest: ObservableObject {
    
    @Published var list = [wout]()
    
    func getData(){
        
        let db = Firestore.firestore()
        db.collection("workouts").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map { d in
                            return wout(id:d.documentID
                                        , title: d["title"] as? String ?? ""
                                        , image: d["image"] as? String ?? ""
                                        , ref1: d["ref1"] as? String ?? "")
                                            
                        }
                    }
                    
                   
                }
            } else {
                return print("error")
            }
        }
    }
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
//login
struct Profiles: Hashable, Codable {  //needs additional variables
    let profileID: Int
    let firstName: String
    let lastName: String
    let age: Int
    let email: String
    let password: String
    let startingWeight: Int
    let currentWeight: Int
    
}

class ViewModel4: ObservableObject{
    @Published var profile: [Profiles] = []
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @State var isSignUpViewActive = false
    
    func fetch() {
        guard let url = URL(string:"https://jsonkeeper.com/b/029W") else {return}
        let task = URLSession.shared.dataTask(with:url) {[weak self]
            data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let profile = try JSONDecoder().decode([Profiles].self, from: data)
                DispatchQueue.main.async {
                    self?.profile = profile
                }
            }
            catch {
                
            }
        }
        task.resume()
    }
    
    func fetchLogin() {
        guard let url = URL(string:"https://genericfitness.azurewebsites.net/api/Profiles/Email/\(email)/Password/\(password)") else {return}
        
        let task = URLSession.shared.dataTask(with:url) {[weak self]
            data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let profile = try JSONDecoder().decode([Profiles].self, from: data)
                DispatchQueue.main.async {
                    self?.profile = profile
                }
            }
            catch {
                
            }
        }
        task.resume()
    }
    
}
    

class LogInViewModel: ObservableObject{
    @Published var profile: [Profiles] = []
    
    @State var isSignUpViewActive = false
    
    func fetchLogin(email: String, password: String) {
        guard let url = URL(string:"https://genericfitness.azurewebsites.net/api/Profiles/Email/\(email)/Password/\(password)") else {return}
        let task = URLSession.shared.dataTask(with:url) {[weak self]
            data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let profile = try JSONDecoder().decode([Profiles].self, from: data)
                DispatchQueue.main.async {
                    if((self?.profile.isEmpty) != nil){
                        self?.isSignUpViewActive = true
                    } else {
                        self?.isSignUpViewActive = false
                    }
                    //self?.profile = profile
                }
            }
            catch {
               
            }
        }
        task.resume()
    }

}

