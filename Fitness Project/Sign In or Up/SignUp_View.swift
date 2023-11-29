//
//  SignUp_View.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/12/23.
//

import SwiftUI
import Firebase

@MainActor
final class SignUpEmail: ObservableObject{
    
    @StateObject private var viewModel = SignUpEmail()
    
    @Published var Email: String = ""
    @Published var Pass: String = ""
    
    func signUp(){
        guard !Email.isEmpty, !Pass.isEmpty else{
            print("invalid information")
            return
        }
        
            
        Task{
            do{
                 let result = try await AuthenticationManager.shared.createUser(email: Email, password: Pass)
            } catch {
                print("Error")
            }
        }
    
    }

}

struct SignUp_View: View {
    @StateObject private var viewModel = SignUpEmail()
    //@State var Email: String = ""
    //@State var Pass: String = ""
    @Binding var selectFeet: Int
    @Binding var selectInch: Int
    @Binding var Name: String
    @State private var isSignInViewActive = false
    @State private var isSignUpCircleActive = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader{
            geo in
            ZStack {
             
               
            }
            .frame(width: 393, height: 852)
            .background(Color(red: 0.84, green: 0.9, blue: 1))
            .cornerRadius(40)
            .shadow(color: .black.opacity(0.15), radius: 37.5, x: 0, y: 0)
            if isSignInViewActive == false {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 398, height: 398)
                    .background(Color(red: 0.38, green: 0.79, blue: 0.93))
                    .cornerRadius(700)
                    .offset(x:-163,y: -292)
                    .zIndex(2)
                    
                Text("Create Account")
                  .font(Font.custom("Raleway", size: 46))
                  .foregroundColor(.white)
                  .frame(width: 216, height: 109, alignment: .bottomLeading)
                  .zIndex(3)
                  .offset(x:33,y: 52)
                Rectangle()
    //                .padding(.top, 600.0)
                  .foregroundColor(.clear)
                  .frame(width: 700, height: 700)
                  .background(Color(red: 0.35, green: 0.71, blue: 0.92))
                  .cornerRadius(700)
                  .offset(x:-184,y: -412)
                  .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 398, height: 398)
                  .background(Color(red: 0.38, green: 0.79, blue: 0.93))
                  .cornerRadius(398)
                  .offset(x:235,y: -16)
                  .zIndex(0)
                Rectangle()
                .zIndex(9)
                  .foregroundColor(.clear)
                  .frame(width: 389, height: 676)
                  .background(
                    Image("Image")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 389, height: 676)
                      
                  )
                  .offset(x:30,y:185)
            }
           
        }.ignoresSafeArea()
        
        Spacer()
            .padding(.top)
        VStack {
         
            TextField("Name", text: $Name)
                .padding()
                .foregroundColor(.black)
                .frame(width: 303, height: 60)
                .background(.white)
                .cornerRadius(20)
                .zIndex(6)
                .autocorrectionDisabled()
            
            TextField("Email", text: $viewModel.Email)
                .padding()
                .foregroundColor(.black)
                .frame(width: 303, height: 60)
                .background(.white)
                .cornerRadius(20)
                .zIndex(6)
                .autocorrectionDisabled()
                
            TextField("Password", text: $viewModel.Pass)
                .padding()
                .foregroundColor(.black)
                .frame(width: 303, height: 60)
                .background(.white)
                .cornerRadius(20)
                .zIndex(6)
                .autocorrectionDisabled()
            
        } .padding(.bottom)
        
        
        
        HStack{
            Spacer()
            Text("Sign Up")
              .font(Font.custom("Raleway", size: 32))
              .foregroundColor(.black)
             
            Spacer()
            Spacer()
            ZStack(alignment: .topLeading){
                Image(systemName: "arrow.right")
                    .foregroundColor(.white)
                    .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    .offset(x:10, y:10)
                    .font(.system(size: 30))
                
                Circle()
                    .foregroundColor(Color(red: 0.38, green: 0.79, blue: 0.93))
                .frame(width: 64, height: 64)
                .onTapGesture {
                    Task{
                        do{
                            viewModel.signUp()
                            isSignUpCircleActive.toggle()
                        }catch{
                            print(error)
                        }
                    }
                }
                .sheet(isPresented: $isSignUpCircleActive) {
                    QuestionView(selectFeet: $selectFeet, selectInch: $selectInch, Name: $Name, Email: $viewModel.Email)
                        .interactiveDismissDisabled()
                }
                
            }
            Spacer()
      
        }
        Spacer()
            .padding(.top)
        HStack{
            Spacer()
            Text("")
            
              
             
            Spacer()
            
            Button(action: {
                isSignInViewActive.toggle()
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Sign In")
            })
            .frame(width: 164, height: 44, alignment: .center)
            .background(
            LinearGradient(
            stops: [
            Gradient.Stop(color: Color(red: 0.63, green: 0.85, blue: 0.98), location: 0.14),
            Gradient.Stop(color: Color(red: 0.04, green: 0.56, blue: 0.85), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0.5, y: -0.48),
            endPoint: UnitPoint(x: 0.5, y: 1.31)
            )
            )
            .foregroundColor(.black)
            .cornerRadius(10.68966)
            .padding(.trailing)
//            .sheet(isPresented: $isSignInViewActive) {
//                ContentView()
//            }
//            .fullScreenCover(isPresented: $isSignInViewActive) {
//                ContentView()
//            }
            
      
        }
        .padding(.bottom)
        .padding(.bottom)
        Spacer()
    }
}

#Preview {
    SignUp_View(selectFeet: .constant(5), selectInch: .constant(7), Name: .constant(""))
}
