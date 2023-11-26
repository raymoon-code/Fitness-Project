//
//  FoodDetailView.swift
//  Fitness Project
//
//  Created by user236922 on 10/24/23.
//

//
//  ExerciseDetailView.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/19/23.
//

import SwiftUI
import AVKit

struct FoodDetailView2: View {
    @State var food: Foods
    
    @State var videoID:String = ""
    
    var body: some View {
       
        ZStack(alignment:.top){
            
//            Color.blue // Set the background color to blue
//                           .ignoresSafeArea()
        GeometryReader { geo in
            
            let geow = geo.size.width
            let geoh = geo.size.height
                VStack (alignment: .center){
                    ScrollView {
                        AsyncImage(url:food.imageURL){
                            phase in
                            if let image = phase.image{
                                image
                                    .resizable()
                                    //.aspectRatio(contentMode: .scaleAspectFill)
                                    .frame(width: geow, height: geoh * 0.5)
                                   
                            }
                        }
                       
                        VStack(alignment:.center){
                            Text(food.name)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .padding(1)
                            HStack{
                                Spacer()
                                Image(systemName: "timer")
                                
                                    .foregroundColor(Color.pink)
                                Text("\(food.minute) minutes")
                                Spacer()
                                Image(systemName: "flame")
                                    .foregroundColor(Color.pink)
                                Text("\(food.kcal) kcal")
                                Spacer()
                            }
                            HStack{
                                ZStack{
                                    VStack{
                                        Text("CARBS")
                                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                                        Text("\(food.carbs)g")
                                            .fontWeight(.heavy)
                                            
                                    }.font(.footnote).frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .multilineTextAlignment(.center)
                                    Circle()
                                        .frame(width: 70)
                                        .foregroundColor(.pink)
                                        .opacity(0.4)
                                        
                                    
                                }
                                ZStack{
                                    VStack{
                                        Text("FAT")
                                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                                        Text("\(food.fat)g")
                                            .fontWeight(.heavy)
                                            
                                    }.font(.footnote).frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .multilineTextAlignment(.center)
                                    Circle()
                                        .frame(width: 70)
                                        .foregroundColor(.green)
                                        .opacity(0.4)
                                        
                                    
                                }
                                ZStack{
                                    VStack{
                                        Text("PROTEIN")
                                            
                                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                                        Text("\(food.protein)g")
                                            .fontWeight(.heavy)
                                            
                                    }.font(.footnote)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .multilineTextAlignment(.center)
                                    Circle()
                                        .frame(width: 70)
                                        .foregroundColor(.yellow)
                                        .opacity(0.4)
                                        
                                    
                                }
                            }
                            Text("Ingredients:")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            ForEach(food.ingredients, id: \.self) { food in
                                HStack{
    //                                Text("- ")
                                    Circle()
                                        .frame(width: 7)
                                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0)/*@END_MENU_TOKEN@*/)
                                    Text(food)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                }
                               
                            }
                            Text("Directions:")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            ForEach(Array(food.directions.enumerated()), id: \.offset) { index, step in
                                VStack(spacing:0){
                                    ZStack{
                                        Circle()
                                            .frame(width: 50)
                                            .foregroundColor(.yellow)
                                        Text("\(index + 1)")
                                            .lineLimit(nil)
                                    }
                                    Text(step)
                                        .multilineTextAlignment(.center)
                                        .font(.title3)
                                        .fontWeight(.heavy)
                                        .lineLimit(4)
                                        .frame(height: geoh * 0.08)
                                        .padding(.leading)
                                        .padding(.trailing)
                                        .minimumScaleFactor(0.5)
                                        
                                        
                                }
                                
                            }.frame(height: geoh * 0.15)
                            
                            
                        } .frame(width: geow  )
                   Spacer()
                    }
                }
            }
        }
    }
}

//#Preview {
//
//    ContentView()
//}

struct FoodDetailView2_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView2(food: Foods(
            name: "Vegetable Stir-Fry",
            minute: 15,
            kcal: 250,
            carbs: 30,
            fat: 8,
            protein: 12,
            ingredients: [
                "Broccoli",
                "Bell peppers",
                "Carrots",
                "Snap peas",
                "Soy sauce",
                "Sesame oil",
                "Garlic",
                "Ginger",
                "Rice"
            ],
            directions: [
                "Chop vegetables into bite-sized pieces.",
                "Heat sesame oil in a pan and add garlic and ginger.",
                "Stir-fry vegetables until tender.",
                "Add soy sauce.",
                "Serve over cooked rice."
            ],
            imageURL: URL(string: "https://lastcallattheoasis.com/wp-content/uploads/2020/06/vegetable_stir_fry.jpg")!
        ))
    }
}
