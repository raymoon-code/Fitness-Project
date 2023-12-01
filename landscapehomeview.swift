//
//  landscapehomeview.swift
//  Fitness Project
//
//  Created by Tran Phat on 12/1/23.
//

import SwiftUI

struct landscapehomeview: View {
    @ObservedObject var viewModel = ViewModelexercises()
    @ObservedObject var viewModel2 = ViewModelFoods()
    @ObservedObject var viewModel3 = ViewModel3()
    
    @State private var searchTerm = ""
    @State private var searchTerm2 = ""
    @State private var searchTerm3 = ""
    
    @Binding var Email: String
    
    var emailFilteredTableExercises: [todo]{
        guard !Email.isEmpty else {return viewModel.exercise}
        return viewModel.exercise.filter {
            exercise in
            return (exercise.email.compare(Email) == .orderedSame || exercise.email.compare("default") == .orderedSame)
        }
    }
    
    var filteredTable: [todo] {
        guard !searchTerm.isEmpty else {return emailFilteredTableExercises}
        return emailFilteredTableExercises.filter {
            exercise in
            return (exercise.name.description.localizedCaseInsensitiveContains(searchTerm) ||
            exercise.difficulty.localizedCaseInsensitiveContains(searchTerm) ||
            exercise.muscle.localizedCaseInsensitiveContains(searchTerm))
        }
        
    }
    
    var emailFilteredTableFoods: [Foods2]{
        guard !Email.isEmpty else {return viewModel2.foods}
        return viewModel2.foods.filter {
            exercise in
            return (exercise.email.compare(Email) == .orderedSame || exercise.email.compare("default") == .orderedSame)
        }
    }
    
    var filteredTable2: [Foods2] {
        guard !searchTerm.isEmpty else {return emailFilteredTableFoods}
        return emailFilteredTableFoods.filter {
            food in
            return (food.name.description.localizedCaseInsensitiveContains(searchTerm) ||
                food.kcal.description.localizedCaseInsensitiveContains(searchTerm) ||
                food.minute.description.localizedCaseInsensitiveContains(searchTerm) ||
                food.ingredients.contains { step in
                        step.localizedCaseInsensitiveContains(searchTerm)
                    
                }
                         
            )
        }
        
    }
    
    var filteredTable3: [Workouts] {
        guard !searchTerm.isEmpty else {return viewModel3.workout}
        return viewModel3.workout.filter {
            workout in
            return workout.title.description.localizedCaseInsensitiveContains(searchTerm)
        }
    }
    
    
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
                    
                    HStack{
//                        Text("")
//                            .frame(height: 0)
//                            .background(ignoresSafeAreaEdges: .all)
                        
                        
                        List{
                            Section( header: Text("Your Exercises")
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.black)){
                                    ForEach(filteredTable) { exercise in
                                        
                                        NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                                            HStack {
                                                
                                                Text("")
                                                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                                        Button("delete"){
                                                            viewModel.deleteExercise(exercise) { success in
                                                                                                if success {
                                                                                                    print("Exercise deleted successfully")
                                                                                                } else {
                                                                                                    print("Failed to delete exercise")
                                                                                                }
                                                                                            }
                                                        }.tint(.red)
                                                    }
                                                
                                                AsyncImage(url: URL(string:exercise.imageURL)){
                                                    phase in
                                                    if let image = phase.image{
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: geow * 0.1, height: geoh * 0.1)
                                                    }
                                                }.padding()
//                                                Text("  ")
                                                //                                Spacer()
                                                VStack (spacing:0){
                                                    Text(exercise.name).font(.system(size: 40)).multilineTextAlignment(.center)
                                                        .frame(width: geow * 0.3, height: geoh * 0.001)
                                                        .fontWeight(.semibold)
                                                        .padding(.top)
                                                        .lineLimit(1)
                                                        .minimumScaleFactor(0.5)
                                                    HStack(spacing:0){
                                                        Spacer()
                                                        VStack(spacing:0){
                                                            Image(exercise.muscle == "glutes" ? "glutes" : exercise.muscle == "full-body" || exercise.muscle == "whole body" ? "full_body" : exercise.muscle == "biceps" ? "Biceps 1" : exercise.muscle == "quadriceps" ? "Quadriceps" : exercise.muscle == "triceps" ? "Triceps 1" : exercise.muscle == "core" ? "lower-abs" : exercise.muscle == "flexibility" ? "flexibility" : "Chest1")
                                                                .resizable()
                                                                .frame(width: geow * 0.05, height: geoh * 0.1)
                                                            
                                                            Text(exercise.muscle.capitalized).font(.subheadline).multilineTextAlignment(.leading)
                                                                .frame(width: geow * 0.1)
                                                                .padding(.bottom)
                                                        }.frame(width: geow * 0.1, height:geoh * 0.3)
                                                        Spacer()
                                                        VStack(alignment:.center,spacing:0){
                                                           
                                                            Image( exercise.difficulty == "beginner" ? "easy" : exercise.difficulty == "intermediate" ? "medium" : "hard")
                                                                .resizable()
                                                                .frame(width: geow * 0.05, height: geoh * 0.1)
                                                                .padding(.top)
                                                            Text(exercise.difficulty.capitalized).font(.subheadline).multilineTextAlignment(.leading)
                                                                .padding(.bottom)
                                                                .padding(.bottom)
                                                            
                                                        }.frame(width: geow * 0.1, height:geoh * 0.3)
                                                        Spacer()
                                                    }.frame(width: geow * 0.4, height:geoh * 0.3)
                                                }
                                            }
                                        }
                                    }
//                                    .onDelete(perform: deleteExercise)
                                    .frame(width:geow * 0.6,height: geoh * 0.30)
                                    
                                    
                                    
                                    
                                    
                                }
                        }
                        
                        .searchable(text: $searchTerm, prompt:"Enter name, level of difficult,minute or kcal" ){
                           
                           
                        } .background(Color(red: 0.625, green: 0.909, blue: 0.965))
                        .listStyle(InsetListStyle())
                        .onAppear {
//                            viewModel.fetch()
                            viewModel2.getData()
                        }.navigationBarTitle("Generic Fitness App", displayMode: .inline)
                            .background(Color.clear)
                        List{
                            Section(
                                header: Text("Your Favorite Foods")
                                    .font(.headline)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)){
                                        ForEach(filteredTable2) { food in
                                            
                                            NavigationLink(destination: FoodDetailView2(food: food, Email: $Email)) {
                                                HStack {
                                                    Text("")
                                                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                                            Button("delete"){
                                                                viewModel2.deleteFood(food) { success in
                                                                    if success {
                                                                        print("Exercise deleted successfully")
                                                                    } else {
                                                                        print("Failed to delete exercise")
                                                                    }
                                                                }
                                                            }.tint(.red)
                                                        }
                                                    AsyncImage(url:food.imageURL){
                                                        phase in
                                                        if let image = phase.image{
                                                            image
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: geow * 0.2, height: geoh * 0.21)
                                                        }
                                                    }
                                                    //                                Spacer()
                                                    VStack {
                                                        Text(food.name).font(.title3).fontWeight(.semibold).multilineTextAlignment(.leading)
                                                            .padding(.bottom,1)
                                                        HStack{
                                                            Image( systemName: "timer")    .foregroundColor(Color.pink)
                                                            Text("\(food.minute) minute")
                                                                .font(.title3).multilineTextAlignment(.leading)
                                                            
                                                            Image( systemName: "flame")
                                                                .foregroundColor(Color.pink)
                                                            Text("\(food.kcal) kcal")
                                                            
                                                                .font(.title3).multilineTextAlignment(.leading)
                                                        }.padding(.leading)
                                                    }
                                                }
                                            }
                                        }
//                                        .onDelete(perform: deleteFood)
                                        .frame(width:geow * 0.6,height: geoh * 0.3)
                                        
                                        
                                        
                                        
                                        
                                    }}
                        .searchable(text: $searchTerm, prompt:"Enter name, level of difficult,minute or kcal" ){
                
                        } .background(Color(red: 0.625, green: 0.909, blue: 0.965))
                        .listStyle(InsetListStyle())
                        .onAppear {
//                            viewModel.fetch()
                            viewModel2.getData()
                            viewModel2.listenForChanges()
                        }.navigationBarTitle("Generic Fitness App", displayMode: .inline)
                            .background(Color.clear)
                        
                        
                        .listStyle(InsetListStyle())
                        //                        .onAppear {
                        //                            viewModel2.fetch()
                        //                        }
                        //                    .navigationBarTitle("Your Favorite Food")
                        
                    }
                    //            .frame(height: geoh * 0.56)
                }
               
                .background(ignoresSafeAreaEdges: .all)
            }
        }
        .onAppear{
            viewModel.getData()
            viewModel.listenForChanges()
            viewModel2.getData()
            viewModel2.listenForChanges()
        }
    }
    
    init(Email: Binding<String>){
        self._Email = Email
        viewModel.getData()
        viewModel.listenForChanges()
        viewModel2.getData()
        viewModel2.listenForChanges()
    }
     
    
//    func deleteExercise(at offsets: IndexSet) {
//        viewModel.exercise.remove(atOffsets: offsets)
//    }
//    func deleteFood(at offsets: IndexSet) {
//        viewModel2.food.remove(atOffsets: offsets)
//    }

    
    struct YouTubeThumbnailView: View {
        let videoURL: String

        // Extract the video ID from the URL
        var videoID: String? {
            if let range = videoURL.range(of: "v=") {
                let startIndex = range.upperBound
                let endIndex = videoURL.index(startIndex, offsetBy: 11) // Assuming the video ID is 11 characters
                return String(videoURL[startIndex..<endIndex])
            }
            return nil
        }

        // Construct the image URL
        var imageURLString: String? {
            if let videoID = videoID {
                return "https://img.youtube.com/vi/\(videoID)/0.jpg"
            }
            return nil
        }

        var body: some View {
            if let imageURL = imageURLString, let url = URL(string: imageURL) {
                return AnyView(AsyncImage(url: url))
            } else {
                return AnyView(Text("Invalid YouTube URL"))
            }
        }
    }
}

//extension UIColor {
//    convenience init(hex: Int) {
//        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
//        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
//        let blue = CGFloat(hex & 0x0000FF) / 255.0
//        self.init(red: red, green: green, blue: blue, alpha: 1.0)
//    }
//}

#Preview {
    landscapehomeview(Email: .constant("dnlonda@cougarnet.uh.edu"))
}
