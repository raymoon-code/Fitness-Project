//
//  SplashScreenView.swift
//  Fitness Project
//
//  Created by Tran Phat on 11/30/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    @Binding var selectFeet: Int
    @Binding var selectInch: Int
    @Binding var selectlb: Int
    @Binding var Name: String
    @Binding var Email: String
    var body: some View {
      
        if isActive {
            ContentView(selectFeet: $selectFeet, selectInch: $selectInch, selectlb: $selectlb, Name: $Name, Email: $Email)
            
        }else{
           
                VStack{
                    VStack{
                        Image("logo3")
                        
                            .resizable()
                            .frame(width: 400.0, height: 250.0)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        
                        
                        
                        
                        withAnimation(.easeIn(duration: 1.2)){
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                    
                }.onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        withAnimation{
                            self.isActive = true
                        }
                    }
                }
            
        }
                 
       
    }
}



#Preview {
    SplashScreenView(selectFeet: .constant(5), selectInch: .constant(5), selectlb: .constant(5), Name: .constant("raymoon"), Email: .constant("r@gmail"))
}
