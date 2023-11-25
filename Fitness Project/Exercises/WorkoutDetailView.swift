//
//  WorkoutDetailView.swift
//  Fitness Project
//
//  Created by user236922 on 10/26/23.
//

import SwiftUI

import Firebase
import FirebaseDatabase
import FirebaseDatabaseSwift
import FirebaseFirestore
import FirebaseFirestoreSwift

struct WorkoutDetailView: View {
    
    @State var workout: wout
    
    @ObservedObject var viewModel3 = ViewModeltest()
    @ObservedObject var model2 = ExerciseViewModel()
//    @State var exercise: todo
    let db = Firestore.firestore()
//    @State var woutlist = ()
//    @State var exercises: todo
    @State private var searchTerm = ""
    
    var body: some View {
        GeometryReader { geo in
            let geow = geo.size.width
            let geoh = geo.size.height
            NavigationView {
           
                
            
            
                
                ZStack(alignment: .top){
                    
                    Rectangle()
                        .background(Color(red: 0.625, green: 0.909, blue: 0.965))
                        .zIndex(1)
                        .frame(height: geoh * 0.0001)
                    
                 
                    List(workout.ref1, id: \.self){ i in
                       
                        
                        ForEach(model2.exercises) { exercise in
                            if i == exercise.id {
                                NavigationLink(destination: testdetail(exercise: exercise)) {
                                                                        HStack {
                                    
                                                                            AsyncImage(url: URL(string:exercise.imageURL)){
                                                                                phase in
                                                                                if let image = phase.image{
                                                                                    image
                                                                                        .resizable()
                                                                                        .aspectRatio(contentMode: .fill)
                                                                                        .frame(width: geow * 0.1, height: geoh * 0.1)
                                                                                }
                                                                            }.padding()
                                                                            Text("  ")
                                                                            //                                Spacer()
                                                                            VStack (spacing:0){
                                                                                Text(exercise.name).font(.system(size: 20)).multilineTextAlignment(.center)
                                                                                    .frame(width: geow * 0.6, height: geoh * 0.04)
                                                                                    .fontWeight(.semibold)
                                                                                    .padding(.top)
                                                                                    .lineLimit(1)
                                                                                    .minimumScaleFactor(0.5)
                                                                                HStack(spacing:1){
                                                                                    VStack(spacing:0){
                                                                                        Image(exercise.muscle == "glutes" ? "glutes" : exercise.muscle == "full-body" || exercise.muscle == "whole body" ? "full_body" : exercise.muscle == "biceps" ? "Biceps 1" : exercise.muscle == "quadriceps" ? "Quadriceps" : exercise.muscle == "triceps" ? "Triceps 1" : exercise.muscle == "core" ? "lower-abs" : exercise.muscle == "flexibility" ? "flexibility" : "Chest1")
                                                                                            .resizable()
                                                                                            .frame(width: 30, height: 30)
                                    
                                                                                        Text(exercise.muscle.capitalized).font(.subheadline).multilineTextAlignment(.leading)
                                                                                            .frame(width: geow * 0.3)
                                                                                            .padding(.bottom)
                                                                                    }
                                                                                    VStack(alignment:.center,spacing:0){
                                                                                        Spacer()
                                                                                        Image( exercise.difficulty == "beginner" ? "easy" : exercise.difficulty == "intermediate" ? "medium" : "hard")
                                                                                            .resizable()
                                                                                            .frame(width: 30, height: 30)
                                                                                            .padding(.top)
                                                                                        Text(exercise.difficulty.capitalized).font(.subheadline).multilineTextAlignment(.leading)
                                                                                            .padding(.bottom)
                                                                                            .padding(.bottom)
                                                                                        Spacer()
                                                                                    }.frame(width: geow * 0.3, height:geoh * 0.06)
                                                                                }
                                                                            }
                                                                        }
                                  
                                }
                                //                                    .onDelete(perform: deleteExercise)
                                .frame(height: geoh * 0.11)
                                
                                
                                
                                
                                }
                            }
                        }
                    
                    
                    .searchable(text: $searchTerm, prompt:"Search Exercises" ){
                        
                        
                    }
                    .background(Color(red: 0.625, green: 0.909, blue: 0.965))
                    .listStyle(InsetListStyle())
                    
                    .navigationBarTitle("Generic Fitness App", displayMode: .inline)
                    .background(Color.clear)
                    
                }
                
                
                //                }
                //            }
                
                
                
            }  
            .onAppear{
                viewModel3.getData()
                model2.fetchExercises()
            }
            
        }
        
        //        init(){
        //            viewModel3.getData()
        //            model2.fetchExercises()
        //    }
        //    }
        //        }
        
    }
    
}

struct FetchExerciseDataView2: View {
    let documentID: String
    @State var exerciseData: [String: Any] = [:]
    
    var body: some View {
        VStack (){
            
            if !exerciseData.isEmpty {
               
//                Text("\(exerciseData.description["name"])")
                ForEach(Array(exerciseData), id: \.0) { key, value in
                    HStack {
                        Text("\(key):")
                                               .fontWeight(.bold)
                                           Spacer()
                        Text("\(value)" as? String ?? "")
                    }
                    .padding(.vertical, 2)
                }
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
                    self.exerciseData = data
                    print(exerciseData)
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



struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workout: wout(id: "NShaY3lbG78jn5StfcOc", title: "Leg Day", image: "https://images.unsplash.com/photo-1620188526357-ff08e03da266?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmFyYmVsbHxlbnwwfHwwfHx8MA%3D%3D", ref1:  ["vSoDhCsGgUZF5nOT4kRJ","YIiZrhFd1axM2Luui42d"]))
    
    }
}
////        WorkoutDetailView(workout:  todo(
////            id: "1", name: "Barbell Glute Bridge",
////                          type: "Strength",
////                           muscle: "Glutes",
////                           equipment: "Barbell",
////                           difficulty: "beginner",
////                           instructions: "4 sets of 15 reps. Rest 45 sec between sets.",
////                    imageURL: "https://img.youtube.com/vi/FMyg_gsA0mI/1.jpg",
////                           videoURL: "https://www.youtube.com/watch?v=FMyg_gsA0mI&ab_channel=GirlsGoneStrong"))
////            }
////        }
//        WorkoutDetailView(workout:wout(id: "1",
//            title: "Default Workout 1",
//            image: "https://lastcallattheoasis.com/wp-content/uploads/2020/06/vegetable_stir_fry.jpg", ref1: "2EYR6xL7jULX1WxHrIBj"
//                                      ), exercise: todo(
//                                                            id: "2EYR6xL7jULX1WxHrIBj", name: "Barbell Glute Bridge",
//                                                                          type: "Strength",
//                                                                           muscle: "Glutes",
//                                                                           equipment: "Barbell",
//                                                                           difficulty: "beginner",
//                                                                           instructions: "4 sets of 15 reps. Rest 45 sec between sets.",
//                                                                    imageURL: "https://img.youtube.com/vi/FMyg_gsA0mI/1.jpg",
//                                                                    videoURL: "https://www.youtube.com/watch?v=FMyg_gsA0mI&ab_channel=GirlsGoneStrong")
//                                                    
//        )
//    }
//}
//exercises: [
////
