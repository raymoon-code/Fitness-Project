//
//  Question2View.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/12/23.
//

import SwiftUI

import Firebase
import FirebaseFirestore


struct Question2View: View {
    @State private var selectlb: Int = 150
//    @State private var selectInch: Int = 0
    @State private var isselected2: Bool = false
    @State private var isFinished: Bool = false
    @Binding var selectFeet: Int
    @Binding var selectInch: Int
    @Binding var Name: String
    @Binding var Email: String
    @Binding var Age: Int
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader {
            geo in
            let gw = geo.size.width
            let gh = geo.size.height * 0.28
            
            
            VStack{
                Text("What is your weight?")
                    .font(
                    Font.custom("Raleway", size: 36)
                    .weight(.bold)
                    )
                    .foregroundColor(.black)
                    .frame(width: gw, height: gh)
                HStack{
                    Text("\(selectlb) lbs" )
                        .onTapGesture {
                            isselected2.toggle()
                        }
                    if isselected2 {
                        Picker("",selection: $selectlb){
                            ForEach(0..<600, id: \.self) {
                                index in
                                Text("\(index)")
                                    .padding()
                            }
                        }
                        .onTapGesture {
                            isselected2.toggle()
                        }.pickerStyle(.wheel)
                    }
                    
                    
                    
                    
                }.font(
                    Font.custom("Raleway", size: 36)
                    .weight(.bold)
                    )
                    .foregroundColor(.black)
                .frame(width: gw, height: gh)
                Button {
                    
                        let db = Firestore.firestore()
                        let collectionRef = db.collection("users")
                        let documentID = UUID().uuidString
                        
                        let newExerciseData: [String: Any] = [
                            //"id": documentID,
                            "name": Name,
                            "age": Age,
                            "current_weight": selectlb,
                            "starting_weight": selectlb,
                            "height_feet": selectFeet,
                            "height_inches": selectInch,
                            "email": Email,
                            
                        ]
                        
                    collectionRef.document(documentID).setData(newExerciseData) { error in
                        if let error = error {
                            print("Error adding document: \(error)")
                        } else {
                            print("Document added successfully with ID: \(documentID)")
                            // Clear the input fields after adding the document
                            
                            //showAlert = true
                            
                        }
                        
                        isFinished.toggle()
                    }
                } label: {
                    Text("Finish")
                    .font(
                    Font.custom("Raleway", size: 36)
                    .weight(.semibold)
                    )
                    .foregroundColor(.black)
                }
                .frame(width: 177, height: 58)
                .background(
                    LinearGradient(
                    stops: [
                    Gradient.Stop(color: Color(red: 0.38, green: 0.79, blue: 0.93), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.68, green: 0.92, blue: 1), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                    )
                    .cornerRadius(19)
                .frame(width: gw, height: gh)
                    .fullScreenCover(isPresented: $isFinished, content: {
                        
                        TabSwiftUIView(selectFeet: $selectFeet, selectInch: $selectInch, selectlb: $selectlb, Email: $Email)
                    })
            }
        }.background(LinearGradient(
            stops: [
            Gradient.Stop(color: Color(red: 0.84, green: 0.89, blue: 0.99), location: 0.00),
            Gradient.Stop(color: Color(red: 0.89, green: 0.97, blue: 1), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1)
            ))
    }
}

#Preview {
    Question2View(selectFeet: .constant(5), selectInch: .constant(7), Name: .constant("Daniel"), Email: .constant("A@Gmail.com"), Age: .constant(18))
}
