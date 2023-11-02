//
//  QuestionView.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/12/23.
//

import SwiftUI

struct QuestionView: View {
    @Binding var selectFeet: Int
    @Binding var selectInch: Int
    @State private var isselected: Bool = false
    @State private var isNext: Bool = false
    var body: some View {
        GeometryReader {
            geo in
            let gw = geo.size.width
            let gh = geo.size.height * 0.28
            
            
            VStack{
                Text("How Tall Are You?")
                    .font(
                    Font.custom("Raleway", size: 36)
                    .weight(.bold)
                    )
                    .foregroundColor(.black)
                    .frame(width: gw, height: gh)
                HStack{
                    Text("\(selectFeet) ft" )
                        .onTapGesture {
                            isselected.toggle()
                        }
                    if isselected {
                        Picker("",selection: $selectFeet){
                            ForEach(0..<100, id: \.self) {
                                index in
                                Text("\(index)")
                                    .padding()
                            }
                        }
                        .onTapGesture {
                            isselected.toggle()
                        }.pickerStyle(.wheel)
                    }
                    
                    Text("\(selectInch) In" )
                        .onTapGesture {
                            isselected.toggle()
                        }
                    if isselected {
                        Picker("",selection: $selectInch){
                            ForEach(0..<100, id: \.self) {
                                index in
                                Text("\(index)")
                                    .padding()
                            }
                        }
                        .onTapGesture {
                            isselected.toggle()
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
                        Question2View(selectFeet: $selectFeet, selectInch: $selectInch)
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
    QuestionView(selectFeet: .constant(5), selectInch: .constant(7))
}
