//
//  FoodView.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/22/23.
//

import SwiftUI

struct FoodView: View {
    @ObservedObject var viewModel2 = ViewModel2()
    @State private var searchTerm = ""
    var filteredTable2: [Foods] {
        guard !searchTerm.isEmpty else {return viewModel2.food}
        return viewModel2.food.filter {
            food in
            return food.name.description.localizedCaseInsensitiveContains(searchTerm) ||
            food.kcal.description.localizedCaseInsensitiveContains(searchTerm) ||
            food.minute.description.localizedCaseInsensitiveContains(searchTerm) ||
            food.ingredients.contains { step in
                    step.localizedCaseInsensitiveContains(searchTerm)
                
            }
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
                        List{
                            Section(
                                header: Text("Your Favorite Foods")
                                    .font(.headline)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)){
                                        ForEach(filteredTable2, id: \.self) { food in
                                            
                                            NavigationLink(destination: FoodDetailView2(food: food)) {
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
                                                                .foregroundColor(Color.pink)
                                                            Text("\(food.minute) minute")
                                                                .font(.title3).multilineTextAlignment(.leading)
                                        
                                                            Image( systemName: "flame")
                                                                .foregroundColor(Color.pink)
                                                            Text("\(food.kcal) kcal")
                                                                .font(.title3).multilineTextAlignment(.leading)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        .onDelete(perform: deleteFood)
                                        .frame(height: geoh * 0.1)
                                        
                                        
                                        
                                        
                                        
                                    }}.onAppear {
                                        
                                        viewModel2.fetch()
                                    }
                        
                        .searchable(text: $searchTerm, prompt:"Enter name, kcal, minute or ingredient" )
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
    func deleteFood(at offsets: IndexSet) {
        viewModel2.food.remove(atOffsets: offsets)
    }
}

#Preview {
    FoodView()
}
