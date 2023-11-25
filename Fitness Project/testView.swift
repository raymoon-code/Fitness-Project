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
    var documentIDs: [String]
    @ObservedObject var model = ViewModeltest()
    @ObservedObject var model2 = ExerciseViewModel()
    let db = Firestore.firestore()
    var body: some View {
        NavigationView{
            List(){
                
                ForEach(model.list){ item in
                    
                    //            Text(exerciseData2.keys)
                    //            Text(item.ref1)
                    //
                    ForEach(model2.exercises.filter { item.ref1.contains($0.id) })  { ex in
                        
                        
                            NavigationLink(destination: testdetail(exercise: ex)) {
                                HStack{
                                    Text("")
                                    AsyncImage(url: URL(string:"\(ex.imageURL)")){
                                        phase in
                                        if let image = phase.image{
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 50, height: 50)
                                            
                                        }
                                    }.padding()
                                    VStack{
                                        Text(ex.name)
                                        HStack{
                                            VStack{
                                                Text("Type:")
                                                Text("\(ex.type)")
                                            }
                                            VStack{
                                                Text("Difficult:")
                                                Text("\(ex.difficulty)")
                                            }
                                        }
                                    }
                                }
                            }
                        
                        
                    }
                }
                //
                //            Text(item.title)
                //
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
                //            FetchExerciseDataView(documentID: item.ref1)
                
            }
            
            
                    .onAppear{
                        model.getData()
                        model2.fetchExercises()
                    }
            //        List(model.exercisebyidtest){
            //            i in
            //            Text(i.description)
            //        }
            //        Text(model.exercisebyidtest.muscle)
        }
    }
//        init(){
//            model.getData()
//            model2.fetchExercises()
//        }
        
    }


struct FetchExerciseDataView: View {
    @ObservedObject var model2 = ViewModeltest()
    let documentIDs: [String]
    @State var exerciseData2: [String: Any] = [:]
   
    
    var body: some View {
       
            HStack {
                
                if !exerciseData2.isEmpty {
                    var  shouldDisplayType = false
                    var sortedKeys = exerciseData2.keys.sorted(by: >)
                   
                    Text("")
                        .onAppear{
                            if let index = sortedKeys.firstIndex(of: "imageURL") {
                                                sortedKeys.remove(at: index)
                                                sortedKeys.insert("imageURL", at: 0)
                                            }
//                            print(sortedKeys)
                        }
//                    if let index = sortedKeys.firstIndex(of: "imageURL") {
//                                       sortedKeys.remove(at: index)
//                                       sortedKeys.insert("imageURL", at: 0) // Move "imageURL" key to the front
//                                   }
                    //                Text("\(exerciseData.description["name"])")
//                    Text(sortedKeys[1])
//                    Text(exerciseData2[sortedKeys[1]])
//                    List(0..<3){ i in
//                        Text(sortedKeys.description)
//                            .frame(width: 100, height: 100)
//                    }
                    
                    ForEach(sortedKeys, id: \.self) { key in
                       
                        if let value = exerciseData2[key] {
                            
//                            if key == "videoURL"{
//                                Text("\(key): \(value as? String ?? "")")
//                            }
//                            HStack{
//                             
//                                AsyncImage(url: URL(string:"\(value)")){
//                                    phase in
//                                    if let image = phase.image{
//                                        image
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fill)
//                                            .frame(width: 100, height: 100)
//                                    }
//                                }.padding()
//                                
//                                    Text(key == "imageURL" ? key : "")
//                                
//                            }
                            
                                if key == "imageURL"  {
                                   
                                    AsyncImage(url: URL(string:"\(value)")){
                                        phase in
                                        if let image = phase.image{
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 50, height: 50)
                                                
                                        }
                                    }.padding()
                                        .onAppear{
                                            shouldDisplayType = true
                                        }
                                    
                                }
                              
                           
                            else if key == "difficulty" {
                                                              Text("\(key): \(value as? String ?? "")")
                                                          }
                         
                                 VStack {
                                     Text(key == "type" ? "Type:" : "")
                                         .fontWeight(.bold)
                                     Text("\(key == "type" ? (value as? String ?? "") : "") ")
                                        
                                 }
                            
//                            VStack{
//                                if key == "type" {
//                                    Text("\(key): \(value as? String ?? "")")
//                                }
//                                if key == "difficulty" {
//                                    Text("\(key): \(value as? String ?? "")")
//                                }
//                            }
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
//                model2.getExerciseByIDtest(documentID: documentID)
                fetchExercisesData(documentIDs: documentIDs)
//                fetchExerciseDocument(documentID: documentID) { data, error in
//                    if let error = error {
//                        print("Error: \(error)")
//                    } else if let data = data {
//                        // Accessing and storing document data
//                        self.exerciseData2 = data
//                        var sortedKeys = exerciseData2.keys.sorted(by: >)
//                       
//                        
//                           
////                        print(exerciseData2)
//                    }
//                
//            }
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
    
    func fetchExercisesData(documentIDs: [String]) {
          for documentID in documentIDs {
              fetchExerciseDocument(documentID: documentID) { data, error in
                  if let error = error {
                      print("Error: \(error)")
                  } else if let data = data {
                      // Aggregate the fetched data for each document ID
                      // You can append or handle the data as needed
                      self.exerciseData2[documentID] = data

                      // Check if all documents are fetched and update the UI
                      if self.exerciseData2.keys.count == documentIDs.count {
                          // Update UI or perform further actions once all data is fetched
                          // You can also manipulate or display the aggregated data here
                          print(self.exerciseData2)
                      }
                  }
              }
          }
      }
    
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
    testView(documentIDs: ["2EYR6xL7jULX1WxHrIBj","YIiZrhFd1axM2Luui42d"])
}
