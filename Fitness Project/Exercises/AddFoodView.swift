//
//  AddFoodView.swift
//  Fitness Project
//
//  Created by Tran Phat on 11/25/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
struct AddFoodView: View {
   
       @State private var name = ""
       @State private var minute = 0
       @State private var kcal = 0
       @State private var carbs = 0
       @State private var fat = 0
       @State private var protein = 0
       @State private var ingredients: [String] = []
       @State private var directions: [String] = []
    @State private var numberInput = "0"
       @State private var imageURL = ""
    @State private var ingredientInput = ""
    @State private var directionInput = ""
       @State private var showAlert = false
    
    var body: some View {
        GeometryReader { geo in
            let geow = geo.size.width
            let geoh = geo.size.height
            NavigationView {
                ZStack(alignment:.top){
                    Rectangle()
                        .background(Color(red: 0.625, green: 0.909, blue: 0.965))
                        .zIndex(1)
                        .frame(height: geoh * 0.00001)
                        .overlay(
                            Text("Generic fittness App").font(.title).multilineTextAlignment(.center).offset(y:-30)
                        )
                    //                    Rectangle()
                    //                        .background(Color(red: 0.625, green: 0.909, blue: 0.965))
                    //                        .zIndex(1)
                    //                        .frame(height: geoh * 0.0000001)
                    //                        .offset(y:1)
                    //                        .overlay {
                    //                            Text("Generic fitness app")
                    //                        }
                    
                    VStack{
                      
                        
                        List {
//                            Text("Generic fitness app")
//                                .multilineTextAlignment(.center).frame(width:geow,height:geoh * 0.08)
////                                .padding()
//                                .background(Color(red: 0.625, green: 0.909, blue: 0.965))
                            Section(header: Text("Food Details")) {
                                TextField("Name", text: $name)
                                //                    Stepper(value: $minute, in: 0...Int.max, label: {
                                //                        Text("Minutes: \(minute)")
                                //
                                //                    })
                                //                    HStack{
                                //                        Text("Minutes: \(minute)")
                                //                        Spacer()
                                //
                                //                        Image(systemName: "minus")
                                //                            .onTapGesture {
                                //                                minute -= 1
                                //                        }
                                //                        TextField("Minutes", value: $minute, formatter: NumberFormatter())
                                //                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                //                            .frame(width: 40)
                                //                            .multilineTextAlignment(.center)
                                //                        Image(systemName: "plus")
                                //                            .onTapGesture {
                                //                            minute += 1
                                //                    }
                                //                    }
                                createCustomNumericInput(label: "Minutes", value: $minute)
                                createCustomNumericInput(label: "kcal", value: $kcal)
                                createCustomNumericInput(label: "Carbs", value: $carbs)
                                createCustomNumericInput(label: "Fat", value: $fat)
                                createCustomNumericInput(label: "Protein", value: $protein)
                                
                                
                                //                    Stepper(value: $kcal, in: 0...1000, label: {
                                //                        Text("Kcal: \(kcal)")
                                //                    })
                                //                    Stepper(value: $carbs, in: 0...100, label: {
                                //                        Text("Carbs: \(carbs)g")
                                //                    })
                                //                    Stepper(value: $fat, in: 0...100, label: {
                                //                        Text("Fat: \(fat)g")
                                //                    })
                                //                    Stepper(value: $protein, in: 0...100, label: {
                                //                        Text("Protein: \(protein)g")
                                //                    })
                                TextField("Image URL", text: $imageURL)
                            }
                            
                            Section(header: Text("Ingredients")) {
                                HStack {
                                    TextField("Add Ingredients separated by commas", text: $ingredientInput)
                                    Button(action: {
                                        addIngredientsFromInput()
                                    }) {
                                        Text("Add")
                                    }
                                }
                                ForEach(0..<ingredients.count, id: \.self) { index in
                                    HStack {
                                        Text("Ingredient \(index + 1): \(ingredients[index])")
                                        Button(action: {
                                            removeIngredient(at: index)
                                        }) {
                                            Image(systemName: "minus.circle").foregroundColor(.red)
                                        }
                                    }
                                }
                            }
                            
                            Section(header: Text("Directions")) {
                                HStack {
                                    TextField("Add Directions separated by commas", text: $directionInput)
                                    Button(action: {
                                        addDirectionsFromInput()
                                    }) {
                                        Text("Add")
                                    }
                                }
                                ForEach(0..<directions.count, id: \.self) { index in
                                    HStack {
                                        Text("Direction \(index + 1): \(directions[index])")
                                        Button(action: {
                                            removeDirection(at: index)
                                        }) {
                                            Image(systemName: "minus.circle").foregroundColor(.red)
                                        }
                                    }
                                }
                            }
                            
                            
                        }
                        .ignoresSafeArea(.all)
                        Button(action: {
                            addFood()
                            
                        }) {
                            Text("Add Food")
                                .padding()
                                .foregroundColor(.black)
                                .background(Color(hue: 0.527, saturation: 0.73, brightness: 0.848))
                                .cornerRadius(8)
                        }
                        .frame(width:geow * 0.8)
                        .padding()
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Food Added"),
                                message: Text("Food has been added successfully"),
                                dismissButton: .default(Text("OK")) {
                                    // Clear the input fields after adding the food
                                    //                            clearFields()
                                    name = ""
                                    minute = 0
                                    kcal = 0
                                    carbs = 0
                                    fat = 0
                                    protein = 0
                                    imageURL = ""
                                    ingredients = []
                                    directions = []
                                    showAlert = false
                                }
                            )
                        }}.padding(.top,15)
                }.background(Color(red: 0.949, green: 0.949, blue: 0.971))
            }}
    }
    func createCustomNumericInput(label: String, value: Binding<Int>) -> some View {
            HStack {
                Text("\(label): \(value.wrappedValue)")
                    .frame(width: 100, alignment: .leading)

                Spacer()

                Image(systemName: "minus")
                    .onTapGesture {
                        value.wrappedValue -= 1
                    }

                TextField(label, value: value, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 60)
                    .multilineTextAlignment(.center)

                Image(systemName: "plus")
                    .onTapGesture {
                        value.wrappedValue += 1
                    }
            }
//            .padding(.vertical, 2)
        }
    
    
    func addDirectionsFromInput() {
        let separatedDirections = directionInput.components(separatedBy: ",")
        directions.append(contentsOf: separatedDirections)
        directionInput = ""
    }
    func addIngredientsFromInput() {
        let separatedIngredients = ingredientInput.components(separatedBy: ",")
        ingredients.append(contentsOf: separatedIngredients)
        ingredientInput = ""
    }
    
    func removeIngredient(at index: Int) {
        guard index < ingredients.count else { return }
        ingredients.remove(at: index)
    }

    func removeDirection(at index: Int) {
        guard index < directions.count else { return }
        directions.remove(at: index)
    }
    
    func addFood() {
        let db = Firestore.firestore()
        let collectionRef = db.collection("Foods")
        let documentID = UUID().uuidString
        
        // Prepare data for the new food item
        let newFoodData: [String: Any] = [
            "id": documentID,
            "name": name,
            "minute": Int(minute) ,
            "kcal": Int(kcal) ,
            "carbs": Int(carbs) ,
            "fat": Int(fat) ,
            "protein": Int(protein) ,
            "ingredients": ingredients,
            "directions": directions,
            "imageURL": imageURL
            // Include other food details as needed...
        ]
        
        collectionRef.document(documentID).setData(newFoodData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully with ID: \(documentID)")
                showAlert = true
            }
        }
    }
            func clearFields() {
                name = " "
                minute = 0
                kcal = 0
                carbs = 0
                fat = 0
                protein = 0
                ingredients = []
                directions = []
                imageURL = " "
            }
        }
        
        #Preview {
            AddFoodView()
        }
    
