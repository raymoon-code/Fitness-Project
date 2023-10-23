//
//  HomeScreenView.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/12/23.
//

import SwiftUI


struct HomeScreenView: View {
    @ObservedObject var viewModel = ViewModel()
    @ObservedObject var viewModel2 = ViewModel2()
    @State private var searchTerm = ""
    @State private var searchTerm2 = ""
    var filteredTable: [Exercise] {
        guard !searchTerm.isEmpty else {return viewModel.exercise}
        return viewModel.exercise.filter {
            exercise in
            return exercise.name.description.localizedCaseInsensitiveContains(searchTerm) ||
            exercise.difficulty.localizedCaseInsensitiveContains(searchTerm) ||
            exercise.muscle.localizedCaseInsensitiveContains(searchTerm)
        }
        
    }
    var filteredTable2: [Foods] {
        guard !searchTerm.isEmpty else {return viewModel2.food}
        return viewModel2.food.filter {
            food in
            return food.name.description.localizedCaseInsensitiveContains(searchTerm) ||
            food.name.localizedCaseInsensitiveContains(searchTerm) ||
            food.directions.localizedCaseInsensitiveContains(searchTerm)
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
                    
                    VStack{
//                        Text("")
//                            .frame(height: 0)
//                            .background(ignoresSafeAreaEdges: .all)
                        
                        
                        List{
                            Section( header: Text("Your Favorite Exercises")
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.black)){
                                    ForEach(filteredTable, id: \.name) { exercise in
                                        
                                        NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                                            HStack {
                                                
                                                
                                                
                                                AsyncImage(url: exercise.imageURL){
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
                                                            Image( "muscle_icon")
                                                                .resizable()
                                                                .frame(width: 30, height: 30)
                                                            
                                                            Text(exercise.muscle).font(.subheadline).multilineTextAlignment(.leading)
                                                                .frame(width: geow * 0.3)
                                                                .padding(.bottom)
                                                        }
                                                        VStack(alignment:.center,spacing:0){
                                                            Spacer()
                                                            Image( exercise.difficulty == "beginner" ? "easy" : exercise.difficulty == "intermediate" ? "medium" : "hard")
                                                                .resizable()
                                                                .frame(width: 30, height: 30)
                                                                .padding(.top)
                                                            Text(exercise.difficulty).font(.subheadline).multilineTextAlignment(.leading)
                                                                .padding(.bottom)
                                                                .padding(.bottom)
                                                            Spacer()
                                                        }.frame(width: geow * 0.3, height:geoh * 0.06)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .onDelete(perform: deleteExercise)
                                    .frame(height: geoh * 0.09)
                                    
                                    
                                    
                                    
                                    
                                }
                        }
                        
                        .searchable(text: $searchTerm, prompt:"Enter name, level of difficult or muscle" ){
                           
                           
                        } .background(Color(red: 0.625, green: 0.909, blue: 0.965))
                        .listStyle(InsetListStyle())
                        .onAppear {
                            viewModel.fetch()
                            viewModel2.fetch()
                        }.navigationBarTitle("Generic Fitness App", displayMode: .inline)
                            .background(Color.clear)
                        List{
                            Section(
                                header: Text("Your Favorite Foods")
                                    .font(.headline)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)){
                                        ForEach(filteredTable2, id: \.self) { food in
                                            
                                            NavigationLink(destination: ExerciseDetailView2(food: food)) {
                                                HStack {
                                                    
                                                    AsyncImage(url:food.imageURL){
                                                        phase in
                                                        if let image = phase.image{
                                                            image
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: geow * 0.2, height: geoh * 0.11)
                                                        }
                                                    }
                                                    //                                Spacer()
                                                    VStack {
                                                        Text(food.name).font(.title3).multilineTextAlignment(.leading)
                                                        HStack{
                                                            Image( systemName: "timer")
                                                            Text("\(food.minute) minute")
                                                                .font(.title3).multilineTextAlignment(.leading)
                                                            //                                                                .resizable()
                                                            //                                                                .frame(width: 30, height: 30)
                                                            
                                                            //                                                            Text("")
                                                            //                                                                .font(.title3).multilineTextAlignment(.leading)
                                                            Image( systemName: "carrot.fill")
                                                            Text("\(food.kcal) kcal")
                                                                .font(.title3).multilineTextAlignment(.leading)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        .onDelete(perform: deleteFood)
                                        .frame(height: geoh * 0.1)
                                        
                                        
                                        
                                        
                                        
                                    }}
                        
                        .searchable(text: $searchTerm, prompt:"Enter name, Type or muscle" )
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
    }
    func deleteExercise(at offsets: IndexSet) {
        viewModel.exercise.remove(atOffsets: offsets)
    }
    func deleteFood(at offsets: IndexSet) {
        viewModel2.food.remove(atOffsets: offsets)
    }

    
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
extension UIColor {
    convenience init(hex: Int) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

#Preview {
    HomeScreenView()
}
