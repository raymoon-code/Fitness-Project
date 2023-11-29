//
//  Question3View.swift
//  Fitness Project
//
//  Created by user236922 on 11/29/23.
//

import SwiftUI

import Firebase
import FirebaseFirestore






/// IMPORTANT: though titled "question3", it is presented second.
/// only named this way to prevent renaming existing views






struct Question3View: View {
    @State private var selectAge: Int = 20
//    @State private var selectInch: Int = 0
    @State private var isselected2: Bool = false
    @State private var isFinished: Bool = false
    @Binding var selectFeet: Int
    @Binding var selectInch: Int
    @Binding var Name: String
    @Binding var Email: String
    
    @State private var isNext: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader {
            geo in
            let gw = geo.size.width
            let gh = geo.size.height * 0.28
            
            
            VStack{
                Text("What Is Your Age?")
                    .font(
                    Font.custom("Raleway", size: 36)
                    .weight(.bold)
                    )
                    .foregroundColor(.black)
                    .frame(width: gw, height: gh)
                HStack{
                    Text("\(selectAge)" )
                        .onTapGesture {
                            isselected2.toggle()
                        }
                    if isselected2 {
                        Picker("",selection: $selectAge){
                            ForEach(0..<100, id: \.self) {
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
                        
                    isNext.toggle()
                    
                } label: {
                    Text("Next")
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
                    .sheet(isPresented: $isNext, content: {
                        Question2View(selectFeet: $selectFeet, selectInch: $selectInch, Name: $Name, Email: $Email, Age: $selectAge)
                        .interactiveDismissDisabled()
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
    Question3View(selectFeet: .constant(5), selectInch: .constant(7), Name: .constant("Daniel"), Email: .constant("A@Gmail.com"))
}
