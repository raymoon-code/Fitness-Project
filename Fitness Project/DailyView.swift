//
//  DailyView.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/25/23.
//

import SwiftUI

struct DailyView: View {
    let today = Date()
    @State var selectedday:Int = 0
    @State var waterFill:[Int] = [0,0,0,0,0,0,0,0]
    @State private var isSheetPresented = false
    @State private var progress: CGFloat = 0.1
    @State private var waveOffset: CGFloat = 0.0
    @State private var startAnimation: CGFloat = 0
    @State private var isWaveAnimating = false
    var body: some View {
        GeometryReader { geo in
            let geow = geo.size.width
            let geoh = geo.size.height
            
            VStack{
                ZStack{
                    Text("Generic Fitness App")
                        .font(
                            Font.custom("Raleway", size: 25)
                                .weight(.medium)
                        )
                        .foregroundColor(.black)
                    
                        .frame(width: geow * 0.9, height: geoh * 0.14, alignment: .topLeading)
                        .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: geow, height: geoh * 0.14)
                        .background(Color(red: 0.62, green: 0.91, blue: 0.96))
                        .cornerRadius(10)
                        .ignoresSafeArea()
                }
                Text("Week goal")
                    .font(
                        Font.custom("Raleway", size: 30)
                            .weight(.semibold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(width: geow * 0.9, height: geoh * 0.14, alignment: .topLeading)
                //                Text(formattedDayOfWeek.prefix(1))
                HStack{
                    ForEach(["Sun","Mon","Tue","Wed","Thu","Fri","Sat"], id: \.self) { day in
                        
                        //                            Text(day)
                        //                            Text(formattedDayOfWeek.prefix(3))
                        Text(day == formattedDayOfWeek.prefix(3) ? "Today" : day)
                        //                                .font(
                        //                                    Font.custom("Raleway", size: day == formattedDayOfWeek.prefix(3) ? 14 : 18)
                        //                                        .weight(.semibold)
                        //
                        //                                )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .lineLimit(2)
                            .frame(width: geow * 0.12, height: 20.9359, alignment: .center)
                    }
                }
                HStack{
                    ForEach([1,2,3,4,5,6,7], id: \.self) { day in
                        VStack{
                            ZStack{
                                //                            let date = formattedDayOfMonth
                                
                                Text("\((((formattedDayOfMonth - 1) - formattednumDayOfWeek + day) % 31 + 1 ) )")
                                    .zIndex(1)
                                Circle()
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(Color(red: 0.62, green: 0.91, blue: 0.96))
                                    .onTapGesture {
                                        // Set the selectedday when the circle is tapped
                                        selectedday =  day
                                    }
                            }
                            Image(systemName: day == selectedday ? "triangle.inset.filled" : "")
                                .resizable()
                                .frame(width: 14, height: 10)
                                .foregroundColor(Color(red: 0.62, green: 0.91, blue: 0.96))
                                .overlay(
                                    Group {
                                        if day == selectedday {
                                            TriangleBorder() // Adjust the corner radius as needed
                                                .stroke(Color.black, lineWidth: 1) // Change the color and line width as needed
                                        }
                                    }
                                )
                            
                        }
                    }
                }
                ZStack {
                    
                    Button(action: {
                        isSheetPresented = true // Toggle the sheet presentation
                        if waterFill[selectedday] == 0 {
                            progress = 0.1
                            withAnimation(.linear(duration: 2.2).repeatForever(autoreverses: false)) {
                                
                                startAnimation = geoh
                                
                            }}
                    }) {
                        VStack{
                            Text("Water")
                                .font(
                                    Font.custom("Raleway", size: 20)
                                        .weight(.semibold)
                                )
                                .foregroundColor(.black)
                            
                                .frame(width: 68, height: 24, alignment: .topLeading)
                            Circle()
                                .frame(width: 143, height: 102)
                                .foregroundColor(.clear)
                                .overlay(
                                    Circle()
                                    
                                        .stroke(Color(red: 0.472, green: 0.484, blue: 0.488), lineWidth: 5) // Specify the stroke color and width
                                )
                                .overlay(
                                    Circle()
                                        .trim(from: 0.75, to: 1.0) // 25% of the circle
                                        .stroke(Color.blue, lineWidth: 5) // Blue stroke
                                        .opacity(waterFill[selectedday] >= 500 ? 1.0 : 0.0)
                                    // Show only when waterFill is over 500
                                )
                                .overlay(
                                    Circle()
                                        .trim(from: 0.0, to: waterFill[selectedday] == 1000 ? 0.25 : waterFill[selectedday] == 1500 ? 0.5 : waterFill[selectedday] >= 2000 ? 0.75 : 0.0) // 25% of the circle
                                        .stroke(Color.blue, lineWidth: 5) // Blue stroke
                                        .opacity(waterFill[selectedday] > 500 ? 1.0 : 0.0)
                                    // Show only when waterFill is over 500
                                )
                                .overlay(VStack{
                                    Image(systemName: "drop.halffull")
                                        .resizable()
                                        .frame(width:20,height:30)
                                        .foregroundColor(.blue)
                                    Text("\(waterFill[selectedday])\n/2000 ml")
                                        .font(.system(size: 12))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    .multilineTextAlignment(.center)}
                                )
                        }// An empty Text to make the entire ZStack tappable
                    }
                }
                .frame(width: 143, height: 152)
                .background(Color(red: 0.32, green: 0.89, blue: 1).opacity(0.37))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .inset(by: 0.5)
                        .stroke(.black, lineWidth: 1)
                )
                .fullScreenCover(isPresented: $isSheetPresented, content: {
                    ZStack{
                        // Place your sheet content here
                        // For example, Text("Sheet Content") or another view
                        VStack{
                            VStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 148, height: 54)
                                    .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                                    .cornerRadius(18)
                                    .overlay {HStack{
                                        Image(systemName: "timer")
                                        let firstnum = ((formattedDayOfMonth - 1) - formattednumDayOfWeek + selectedday) % 31 + 1
                                        let secondnum = ((formattedDayOfMonth - 1) - formattednumDayOfWeek + (selectedday - 1)) % 31 + 1
//                                        let thismonth = formattedFullDate(monthsInFuture: 0)
                                        let nextmonth =   formattedFullDate(monthsInFuture: 1)
                                       
//                                        Text("\(((formattedDayOfMonth - 1) - formattednumDayOfWeek + (selectedday + 1)) % 31 + 1) ")
//                                        Text("\(formattedFullDate(monthsInFuture: 1)) \(((formattedDayOfMonth - 1) - formattednumDayOfWeek + selectedday) % 31 + 1) ")
                                       
                                        Text( secondnum - firstnum  > 1 ? nextmonth : monthForPastDay(daysAgo: selectedday - 1)!)
                                            .font(.title).font(
                                                Font.custom("Raleway", size: 30)
                                                    .weight(.bold)
                                            )
                                        Text("\(((formattedDayOfMonth - 1) - formattednumDayOfWeek + selectedday) % 31 + 1) ").font(.title).font(
                                            Font.custom("Raleway", size: 30)
                                                .weight(.bold)
                                        )
                                    }
                                    }.padding()
                                   
                                    
                                
                                Spacer()
                                Text("\(waterFill[selectedday]) ml")
                                    .fontWeight(.heavy)
                                    .padding()
                                    .font(.largeTitle).font(
                                        Font.custom("Raleway", size: 48)
                                            .weight(.bold)
                                    )
                                Text("Goal: 2000ml")
                                    .font(.title).font(
                                        Font.custom("Raleway", size: 20)
                                        
                                    )
                                Spacer()
                            }.zIndex(1)
                            
                            Spacer()
                            HStack{
                                Spacer()
                                Button(action: {
                                    isSheetPresented = false
                                    startAnimation = 0
                                    
                                }){
                                    Circle()
                                        .frame(width:50)
                                        .foregroundColor(.gray)
                                        .opacity(0.7)
                                        .overlay {
                                            Text("X")
                                                .font(.title2)
                                                .fontWeight(.heavy)
                                        }
                                    //                                Image(systemName: "xmark.app")
                                }
                                .foregroundColor(Color.white)
                                Spacer()
                                Button(action:{
                                    
                                    withAnimation { waterFill[selectedday] += 500
                                        if waterFill[selectedday] <= 2000 {
                                            let newvalue = progress + 0.25
                                            progress = newvalue
                                        }
                                    }
                                }){
                                    ZStack{
                                        Circle()
                                            .frame(width:90,height:90)
                                            .foregroundColor(.white)
                                            .overlay {
                                                VStack(spacing:0){
                                                    HStack(spacing:5){
                                                        Image(systemName: "waterbottle")
                                                            .resizable()
                                                            .frame(width:20,height:40)
                                                        Text("+")
                                                            .font(.title)
                                                    }
                                                    Text("500ml")
                                                }
                                            }
                                            .zIndex(1)
                                            
                                        
                                        
                                        
                                    }.padding()
                                    
                                    
                                }
                                Spacer()
                                Text("      ")
                                    .padding()
                                Spacer()
                            }
                            Spacer()
                        }.zIndex(1)
                        ZStack{
                            Wave(progress: progress, waveHeight: 0.02,offset: startAnimation)
                                .offset(y:40)
                                .fill(Color.blue)
                                .zIndex(0)
                            
                        }.onAppear{
                            withAnimation(.linear(duration: 2.2).repeatForever(autoreverses: false)) {
                                
                                startAnimation = geoh
                                
                            }
                            if waterFill[selectedday] == 0 {
                                progress = 0.1
                                
                                
                            } else if waterFill[selectedday] == 500 {
                                progress = 0.35
                                withAnimation(.linear(duration: 2.2).repeatForever(autoreverses: false)) {
                                    startAnimation = geoh
                                    
                                }
                            } else if waterFill[selectedday] == 1000 {
                                progress = 0.6
                                withAnimation(.linear(duration: 2.2).repeatForever(autoreverses: false)) {
                                    startAnimation = geoh
                                    
                                }
                            } else if waterFill[selectedday] == 1500 {
                                progress = 0.85
                                withAnimation(.linear(duration: 2.2).repeatForever(autoreverses: false)) {
                                    startAnimation = geoh
                                    
                                }
                            } else {
                                progress = 1.1
                                withAnimation(.linear(duration: 2.2).repeatForever(autoreverses: false)) {
                                    startAnimation = geoh
                                }
                            }
                        }
                            
                        
                    }
                    
                        .onDisappear{
                            isSheetPresented = false
                            startAnimation = geoh
                            
      
                        }
                })
                    
                   
                
                
                
            }
               
            }
        .onAppear {
                  
                  selectedday = formattednumDayOfWeek
           
              }
        
        }
    
    var formattedDayOfWeek: String {
//          let calendar = Calendar.current
//          let dayOfWeek = calendar.component(.weekday, from: today)
          
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "EEEE" // This will give you the full day name
          return dateFormatter.string(from: today)
      }
    
    func monthForPastDay(daysAgo: Int) -> String? {
        let calendar = Calendar.current
        let targetDate = calendar.date(byAdding: .day, value: daysAgo, to: Date())
        
        if let targetDate = targetDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            return dateFormatter.string(from: targetDate)
        } else {
            return nil
        }
    }
    
//    var formattedFullDate: String {
//        let today = Date()
//        let calendar = Calendar.current
//        if let nextMonth = calendar.date(byAdding: .month, value: 0, to: today) {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MMM"
//            return dateFormatter.string(from: nextMonth)
//        } else {
//            return ""
//        }
//    }
    
    func formattedFullDate(monthsInFuture: Int) -> String {
        let today = Date()
        let calendar = Calendar.current
        if let futureDate = calendar.date(byAdding: .month, value: monthsInFuture, to: today) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            return dateFormatter.string(from: futureDate)
        } else {
            return ""
        }
    }
    
    var formattedDayOfMonth: Int {
        let calendar = Calendar.current
        let dayOfMonth = calendar.component(.day, from: today)
//        dayOfMonth += 1
//
//         // Ensure it wraps around to the range 1-7 (Sunday to Saturday)
//         if dayOfMonth > 31 {
//             dayOfMonth -= 31
//         }
        
        
        return dayOfMonth
    }
    
    var formattednumDayOfWeek: Int {
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: today)
        return dayOfWeek
    }
//    func startWaveAnimation() {
//        isWaveAnimating.toggle()
//           withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: false)) {
//               self.waveOffset = geow
//           }
//       }
}

struct Wave: Shape {
    var progress: CGFloat
    var waveHeight: CGFloat
    var offset: CGFloat
    
    var animatableData: CGFloat {
        get {offset}
        set{offset = newValue}
    }
   
    
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            
            path.move(to: .zero)
            
            let progressHeight: CGFloat = (1 - progress) * rect.height
            let height = waveHeight * rect.height
            
            for value in stride(from: 0, to: rect.width, by: 2.2) {
                
                let x: CGFloat = value
                let sine: CGFloat = sin( Angle(degrees: value + offset).radians )
                let y: CGFloat = progressHeight + (height * sine) + 50
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            
        }
    }
}



struct TriangleBorder: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // Top point
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // Bottom-left point
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // Bottom-right point
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY)) // Back to the top
        return path
    }
}

//#Preview {
//    DailyView()
//}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView()
            
    }
}
