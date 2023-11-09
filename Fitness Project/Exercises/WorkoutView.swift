//
//  WorkoutView.swift
//  Fitness Project
//
//  Created by user236922 on 10/26/23.
//

import SwiftUI

struct WorkoutView: View {
    
    @ObservedObject var viewModel3 = ViewModeltest()
    @ObservedObject var viewModel = ViewModel()
    
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
                        //                            .onAppear {
                        //                                viewModel3.fetch()
                        //                            }
                            .navigationBarTitle("Generic Fitness App", displayMode: .inline)
                            .background(Color.clear)
                    }
                }
            }
        }
        
    }
    init(){
        viewModel3.getData()
    }
    func deleteWorkout(at offsets: IndexSet) {
        viewModel3.list.remove(atOffsets: offsets)
    }
}
#Preview {
    WorkoutView()
}
