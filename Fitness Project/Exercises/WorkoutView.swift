//
//  WorkoutView.swift
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

struct WorkoutView: View {
    @State var woutref = [String]()
    @ObservedObject var viewModel3 = ViewModeltest()
    @ObservedObject var viewModel = ViewModel()
    @State var exercise: todo
    @State private var searchTerm = ""
    
    var filteredTable3: [wout] {
        guard !searchTerm.isEmpty else {return viewModel3.list}
        return viewModel3.list.filter {
            workout in
            return workout.title.description.localizedCaseInsensitiveContains(searchTerm)
        }
    }
    
    var body: some View {
        
        GeometryReader { geo in
            let height = geo.size.height
            let width = geo.size.width
            
            
            NavigationStack{
                ZStack(alignment: .top){
                    
                    Rectangle()
                        .background(Color(red: 0.625, green: 0.909, blue: 0.965))
                        .zIndex(1)
                        .frame(height: height * 0.0001)
                    
                    VStack{
                        
                        List{
                            Section( header: Text("Your Workouts")
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.black)){
                                    
                                    ForEach(filteredTable3) { workout in
                                        NavigationLink(destination: WorkoutDetailView(workout: workout)){
                                            HStack{
                                                Text("")
//
                                                Spacer()
                                                AsyncImage(url: URL(string:workout.image)){
                                                    phase in
                                                    if let image = phase.image{
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: width * 0.1, height: height * 0.1)
                                                    }
                                                }
                                                Spacer()
                                                VStack{
                                                    
                                                    Text(workout.title)
                                                        .fontWeight(.bold)
                                                 
                                                    //                                                    Text("No. Exercises: " + String(workout.exercises.count))
                                                    
                                                }
                                                .frame(width: width * 0.5)
//                                                Text(workout.ref1[0])
                                                Spacer()
                                                
                                            }
                                        }
                                        .isDetailLink(true)
                                    }
                                    .onDelete(perform: deleteWorkout)
                                }
                        }
                        .searchable(text: $searchTerm, prompt:"Enter name of the workout" ){
                            
                            
                        } .background(Color(red: 0.625, green: 0.909, blue: 0.965))
                            .listStyle(InsetListStyle())
                            .onAppear{
                                viewModel3.getData2()
                                viewModel3.listenForChanges()
                            }
                        //                            .onAppear {
                        //                                viewModel3.fetch()
                        //                            }
                            .navigationBarTitle("Generic Fitness App", displayMode: .inline)
                            .background(Color.clear)
                        NavigationLink(destination: AddWorkoutView()) {
                            Text("Add New Workout")
                                .font(.headline)
                                .padding()
                                .foregroundColor(.black)
                                .background(Color(hue: 0.527, saturation: 0.73, brightness: 0.848))
                                .cornerRadius(8)
                        }.navigationViewStyle(StackNavigationViewStyle())
                        .padding()
                    }
                }
            }
        
        }
        
    }
//    init(){
//        
//    }
    func deleteWorkout(at offsets: IndexSet) {
        viewModel3.list.remove(atOffsets: offsets)
    }
    
}
struct FetchExerciseDataView3: View {
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
#Preview {
    WorkoutView( exercise: todo(
        id: "1", name: "Barbell Glute Bridge",
                      type: "Strength",
                       muscle: "Glutes",
                       equipment: "Barbell",
                       difficulty: "beginner",
                       instructions: "4 sets of 15 reps. Rest 45 sec between sets.",
                imageURL: "https://img.youtube.com/vi/FMyg_gsA0mI/1.jpg",
                       videoURL: "https://www.youtube.com/watch?v=FMyg_gsA0mI&ab_channel=GirlsGoneStrong"))
}
