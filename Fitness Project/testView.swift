//
//  testView.swift
//  Fitness Project
//
//  Created by Tran Phat on 11/8/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
struct testView: View {
    @ObservedObject var model = ViewModeltest()
    let db = Firestore.firestore()
    var body: some View {
        List(model.list){ item in
            Text(item.ref1)
            
            
            Text(item.title)
            
//                AsyncImage(url: URL(string: item.image)) { phase in
//                    if let image = phase.image {
//                        image
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                    } else if phase.error != nil {
//                        // Handle error
//                        Text("Failed to load image")
//                    }
//                }
                FetchExerciseDataView(documentID: item.ref1)
            
        }
        
    }
    
    init(){
        model.getData()
    }
    
}

struct FetchExerciseDataView: View {
    let documentID: String
    @State var exerciseData2: [String: Any] = [:]
    
    var body: some View {
       
            HStack {
                
                if !exerciseData2.isEmpty {
                    var sortedKeys = exerciseData2.keys.sorted(by: >)
//                    if let index = sortedKeys.firstIndex(of: "imageURL") {
//                                       sortedKeys.remove(at: index)
//                                       sortedKeys.insert("imageURL", at: 0) // Move "imageURL" key to the front
//                                   }
                    //                Text("\(exerciseData.description["name"])")
                    ForEach(sortedKeys, id: \.self) { key in
                        if let value = exerciseData2[key] {
                            if key == "imageURL" {
                                
                                AsyncImage(url: URL(string:"\(value)")){
                                    phase in
                                    if let image = phase.image{
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                    }
                                }.padding()
                            }
                            VStack{
                                if key == "type" {
                                    Text("\(key): \(value as? String ?? "")")
                                }
                                if key == "difficulty" {
                                    Text("\(key): \(value as? String ?? "")")
                                }
                            }
                            //                            Text("\(key):")
                            //                                .fontWeight(.bold)
                            //                            Spacer()
                            //                            Text("\(value)" as? String ?? "")
                            
                            //                        .padding(.vertical, 2)
                        }}
                } else {
                    Text("Fetching exercise data...")
                        .foregroundColor(.gray)
                }
            }
            .onAppear {
                fetchExerciseDocument(documentID: documentID) { data, error in
                    if let error = error {
                        print("Error: \(error)")
                    } else if let data = data {
                        // Accessing and storing document data
                        self.exerciseData2 = data
                        print(exerciseData2)
                    }
                
            }
        }
    }
    //    func fetchExerciseDocument(documentID: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
    //        let db = Firestore.firestore()
    //        db.collection("exercises").getDocuments{ snapshot, error in
    //        if error == nil {
    //            if let snapshot = snapshot {
    //                DispatchQueue.main.async {
    //                    self.exerciseData = snapshot.documents.map { d in
    //                        return todo( id:d.documentID, name: d["name"] as? String ?? "",
    //                                         type: d["type"] as? String ?? "",
    //                                         muscle: d["muscle"] as? String ?? "",
    //                                         equipment: d["equipment"] as? String ?? "",
    //                                         difficulty: d["difficulty"] as? String ?? "",
    //                                         instructions: d["instructions"] as? String ?? "",
    //                                         imageURL: (d["imageURL"] as? String ?? ""),
    //                                         videoURL: d["videoURL"] as? String ?? "")
    //                    }
    //                }
    //
    //
    //            }
    //        }
    //    }
    //}
    func fetchExerciseDocument(documentID: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("exercises").document(documentID).getDocument { document, error in
            if let error = error {
                completion(nil, error)
            } else if let document = document, document.exists {
                if let data = document.data() {
                    completion(data, nil)
                } else {
                    completion(nil, nil)
                }
            } else {
                completion(nil, nil)
            }
        }
    }
}
#Preview {
    testView()
}
