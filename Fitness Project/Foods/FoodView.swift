//
//  FoodView.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/22/23.
//

import SwiftUI

struct FoodView: View {
    @ObservedObject var viewModel2 = ViewModelFoods()
    @State private var searchTerm = ""
    var filteredTable2: [Foods2] {
        guard !searchTerm.isEmpty else {return viewModel2.foods}
        return viewModel2.foods.filter {
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
                                        ForEach(filteredTable2) { food in
                                            
                                            NavigationLink(destination: FoodDetailView2(food: food)) {
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
                                                                .frame(width: geow * 0.2, height: geoh * 0.11)
                                                        }
                                                    }
                                                    //                                Spacer()
                                                    VStack {
                                                        Text(food.name).font(.title3).multilineTextAlignment(.leading)
                                                        HStack{
                                                            Image( systemName: "timer")
                                                                .foregroundColor(Color.pink)
                                                            Text("\(food.minute) Minutes")
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
                                        }
//                                        .onDelete(perform: deleteFood)
                                        .frame(height: geoh * 0.1)
                                        
                                        
                                        
                                        
                                        
                                    }.onAppear {
                                        
                                        viewModel2.getData()
                                        viewModel2.listenForChanges()
                                    }
                        
                        .searchable(text: $searchTerm, prompt:"Enter name, kcal, minute or ingredient" )
                        .listStyle(InsetListStyle())
                    NavigationLink(destination: AddFoodView()) {
                        Text("Add New Food")
                            .font(.headline)
                            .padding()
                            .foregroundColor(.black)
                            .background(Color(hue: 0.527, saturation: 0.73, brightness: 0.848))
                            .cornerRadius(8)
                    }.navigationViewStyle(StackNavigationViewStyle())
                            .padding()
                    }
                        //                        .onAppear {
                        //                            viewModel2.fetch()
                        //                        }
                        //                    .navigationBarTitle("Your Favorite Food")
                        
//                    }
                    //            .frame(height: geoh * 0.56)
                }
                
//                .background(ignoresSafeAreaEdges: .all)
               
            }
        }
       
    }
//    func deleteFood(at offsets: IndexSet) {
//        viewModel2.food.remove(atOffsets: offsets)
//    }
}

#Preview {
    FoodView()
}
