//
//  Question2View.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/12/23.
//

import SwiftUI

struct Question2View: View {
    @State private var selectlb: Int = 0
    @State private var selectInch: Int = 0
    @State private var isselected2: Bool = false
    @State private var isFinished: Bool = false
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
                            ForEach(140..<300, id: \.self) {
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
                  
                    isFinished.toggle()
                    
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
                        
                        HomeScreenView()
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
    Question2View()
}
