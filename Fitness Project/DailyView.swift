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
    @State private var startAnimation2: CGFloat = 200
    @State private var isWaveAnimating = false
    @State private var shouldAnimate = false
    @State private var timer: Timer?
    @State private var isButtonEnabled = true
    @ObservedObject var viewModel3 = ViewModel3()
    @State private var searchTerm = ""
    @Binding var selectFeet: Int
    @Binding var selectInch: Int
    @Binding var selectlb: Int
    
    var bmi: Double {
        let totalInches = (selectFeet * 12) + selectInch
        let weightInKg = Double(selectlb) * 0.453592
        if totalInches > 0 {
            return (weightInKg / pow(Double(totalInches) * 0.0254, 2))
        } else {
            return 0
        }
    }
    
    var filteredTable3: [Workouts] {
        guard !searchTerm.isEmpty else {return viewModel3.workout}
        return viewModel3.workout.filter {
            workout in
            return workout.title.description.localizedCaseInsensitiveContains(searchTerm)
        }
       
    }
    var randomWorkouts: [Workouts] {
        let shuffledWorkouts = filteredTable3.shuffled()
            return Array(shuffledWorkouts.prefix(2))
        }
    var body: some View {
        NavigationStack{
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
                    
                        .frame(width: geow * 0.9, height: geoh * 0.14, alignment: .leading)
                        .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: geow, height: geoh * 0.14)
                        .background(Color(red: 0.62, green: 0.91, blue: 0.96))
                        .cornerRadius(10)
                        .ignoresSafeArea()
                }.frame(height: geoh * 0.07)
                   
                Text("Week goal")
                    .font(
                        Font.custom("Raleway", size: 30)
                            .weight(.semibold)
                    )
//                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(width: geow * 0.9, alignment: .topLeading)
                    .padding()
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
                                let date = "\((((formattedDayOfMonth - 1) - formattednumDayOfWeek + day) % 31 + 1 ) )"
                                let lastday = lastDayOfPreviousMonth()
                                let lastDayInt = Int(lastday!)
                              
                                Text(date == "0" ? lastday! : 
                                        date == "-1" ? "\(String(describing: lastDayInt! - 1))" :
                                        date == "-2" ? "\(String(describing: lastDayInt! - 2))" :
                                        date == "-3" ? "\(String(describing: lastDayInt! - 3))" :
                                        date == "-4" ? "\(String(describing: lastDayInt! - 4))" :
                                        date == "-5" ? "\(String(describing: lastDayInt! - 5))" :
                                        date == "-6" ? "\(String(describing: lastDayInt! - 6))" :
                                     date )
                                    .zIndex(1)
                                Circle()
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(Color(red: 0.62, green: 0.91, blue: 0.96))
                                    .onTapGesture {
                                        // Set the selectedday when the circle is tapped
                                        selectedday =  day
                                        if waterFill[selectedday] == 0 {
                                            progress = 0.1
                                            
                                            
                                        } else if waterFill[selectedday] == 500 {
                                            

                                                progress = 0.35

                                        } else if waterFill[selectedday] == 1000 {
                                            progress = 0.6
                                           
                                        } else if waterFill[selectedday] == 1500 {
                                            progress = 0.85
                                            
                                        } else {
                                            progress = 1.1
                                           
                                        }
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
               
                   
                ZStack{
                   
                        
                        
                        VStack{
                           
                            List{
                                Section( header: Text("Today's schedule")
                                    .font(.headline)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)){
                                        
                                        ForEach(randomWorkouts, id: \.title) { workout in
                                            NavigationLink(destination: WorkoutDetailView(workout: workout)){
                                                HStack{
                                                    Text("   ")
                                                    Spacer()
                                                    AsyncImage(url: workout.image){
                                                        phase in
                                                        if let image = phase.image{
                                                            image
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fill)
                                                                .frame(width: geow * 0.2, height: geoh * 0.1)
                                                        }
                                                    }
                                                    Spacer()
                                                    VStack{
                                                        
                                                        Text(workout.title)
                                                            .fontWeight(.bold)
                                                        Text("No. Exercises: " + String(workout.exercises.count))
                                                        
                                                    }
                                                    .frame(width: geow * 0.4)
                                                    Spacer()
                                                    
                                                }
                                            }
                                            .isDetailLink(true)
                                           
                                        }
                                        
                                    }
                            }
                            

                            .listStyle(InsetGroupedListStyle())
                            .onAppear {
                                viewModel3.fetch()
                            }
                        }.frame(height: geoh * 0.36)
                        
                    }.frame(width: geow * 0.9)
                    .cornerRadius(20)
                   
                    
                    
                    
               
                HStack {
                    Spacer()
                    ZStack {
                        
                        Button(action: {
                            isSheetPresented = true // Toggle the sheet presentation
                            if waterFill[selectedday] == 0 {
                                progress = 0.1
                                
                                
                                startAnimation = geoh
                                startAnimation2 = geoh + 200
                                
                            }
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
                                            
                                            let lastmonth =   formattedFullDate(monthsInFuture: -1)
                                            
                                            //                                        Text("\(((formattedDayOfMonth - 1) - formattednumDayOfWeek + (selectedday + 1)) % 31 + 1) ")
                                            //                                        Text("\(formattedFullDate(monthsInFuture: 1)) \(((formattedDayOfMonth - 1) - formattednumDayOfWeek + selectedday) % 31 + 1) ")
//                                            Text("\(secondnum)")
//                                            Text("\(firstnum)")
                                            Text( secondnum - firstnum  > 1 ? nextmonth :  secondnum + firstnum  < 1 ? lastmonth : monthForPastDay(daysAgo: selectedday - 1)!)
                                                .font(.title).font(
                                                    Font.custom("Raleway", size: 30)
                                                        .weight(.bold)
                                                )
                                            let d = "\(((formattedDayOfMonth - 1) - formattednumDayOfWeek + selectedday) % 31 + 1)"
                                            let ld = lastDayOfPreviousMonth()
                                            let ldInt = Int(ld!)
//                                            Text(d == "0" ? "ka" : "ko" )
//                                            Text(ld!)
//                                            Text("\(String(describing: ldInt! - 1))")
                                            Text(d == "0" ? ld! :
                                                    d == "-1" ? "\(String(describing: ldInt! - 1))" :
                                                    d == "-2" ? "\(String(describing: ldInt! - 2))" :
                                                    d == "-3" ? "\(String(describing: ldInt! - 3))" :
                                                    d == "-4" ? "\(String(describing: ldInt! - 4))" :
                                                    d == "-5" ? "\(String(describing: ldInt! - 5))" :
                                                    d == "-6" ? "\(String(describing: ldInt! - 6))" :
                                                 d )
                                                .font(.title).font(
                                                Font.custom("Raleway", size: 30)
                                                    .weight(.bold)
                                            )
                                        }
                                        }.padding()
                                    
                                    Spacer()
                                   
                                    Text(waterFill[selectedday] >= 2000 ? "🎊 Excellent job! You've successfully reached your goal" : waterFill[selectedday] == 1000 ? "👏 Great work! You're making fantastic progress" : waterFill[selectedday] == 1500 ? "🙌You're almost there! Keep up the good work." : "" )
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .font(.largeTitle).font(
                                            Font.custom("Raleway", size: 18)
                                                .weight(.bold)
                                        )
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
                                        startAnimation2 = 200
                                        
                                        
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
                                    }.disabled(!isButtonEnabled)
                                        .foregroundColor(Color.white)
                                    Spacer()
                                    Button(action:{
                                        
                                        waterFill[selectedday] += 500
                                        timer?.invalidate()
                                        startProgressTimer()
                                        
                                        
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
                                        
                                        
                                    }.disabled(!isButtonEnabled)
                                    Spacer()
                                    Text("      ")
                                        .padding()
                                    Spacer()
                                }
                                Spacer()
                            }.zIndex(1)
                            ZStack{
                                Wave(progress: progress, waveHeight: 0.012,offset: startAnimation)
                                    .offset(y:40)
                                    .fill(Color.blue)
                                    .opacity(0.9)
                                    .zIndex(0)
                                    .onAppear {
                                        
                                        
                                        
                                        withAnimation(Animation.linear(duration: 30.2).repeatForever(autoreverses: false)) {
                                            
                                            startAnimation = 12600// Change the progress value to make the wave move
                                        }
                                    }
                                Wave(progress: progress  , waveHeight: 0.015,offset: startAnimation2)
                                    .offset(y:40)
                                    .fill(Color.blue)
                                    .opacity(0.3)
                                    .zIndex(0)
                                    .onAppear {
                                        
                                        
                                        
                                        withAnimation(Animation.linear(duration: 30.2).repeatForever(autoreverses: false)) {
                                            
                                            startAnimation2 = 12900// Change the progress value to make the wave move
                                        }
                                    }
                                
                            }
                            
                            
                        }
                        
                        .onDisappear{
                            
                            isSheetPresented = false
                            startAnimation = 0
                            startAnimation2 = 0 + 200
                            
                            
                        }
                    })
                    Spacer()
                    ZStack {
                        VStack{
                            Text("BMI")
                                .font(
                                    Font.custom("Raleway", size: 20)
                                        .weight(.semibold)
                                )
                                .offset(x: -28)
                                .foregroundColor(.black)
                            
                            
                                .frame(width: 68, height: 24, alignment: .topLeading)
                            Circle()
                                .frame(width: 143, height: 102)
                                .foregroundColor(.clear)
                                .overlay(
                                    ZStack {
                                    Text("Normal")
                                        .font(
                                            Font.custom("Raleway", size: 12)
                                                .weight(.heavy)
                                        )
                                        .font(.largeTitle)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.white)

                                        .offset(x:-2,y:-49)
                                        .zIndex(1)
                                    Circle()
                                        .trim(from: 0.66, to: 0.82)
                                        .stroke(Color.green, lineWidth: 30) // Specify the stroke color and width
                                    }
                                )
                                .overlay(
                                    ZStack{
                                        Text("Over")
                                            .font(
                                                Font.custom("Raleway", size: 12)
                                                    .weight(.heavy)
                                            )
                                            .font(.largeTitle)
                                            .fontWeight(.heavy)
                                            .foregroundColor(.white)
                                            .rotationEffect(.degrees(69), anchor: .center)
                                            .offset(x:45, y:-23)
                                            .zIndex(1)
                                        Circle()
                                            .trim(from: 0.82, to: 1.0) // 25% of the circle
                                            .stroke(Color.red, lineWidth: 30) // Blue stroke
                                            .opacity(1.0 )
                                    }
                                    // Show only when waterFill is over 500
                                )
                                .overlay(
                                    ZStack{
                                        Text("Under")
                                            .font(
                                                Font.custom("Raleway", size: 12)
                                                    .weight(.heavy)
                                            )
                                            .font(.largeTitle)
                                            .fontWeight(.heavy)
                                            .foregroundColor(.white)
                                            .rotationEffect(.degrees(-69), anchor: .center)
                                            .offset(x:-45, y:-23)
                                            .zIndex(1)
                                        Circle()
                                            .trim(from: 0.5, to: 0.66) // 25% of the circle
                                            .stroke(Color.blue, lineWidth: 30) // Blue stroke
                                            .opacity(1.0 )
                                            
                                    }
                                
                                   
                                )

                                .overlay(VStack{
                                    Image(bmi < 18.4 ? "Under" : bmi >= 18.4 && bmi < 24.9 ? "Normal" : bmi >= 24.9 ? "Over" : "house")
                                        .resizable()
                                        .frame(width:60,height:60)
                                        .foregroundColor(.black)
                                    
                                        .offset(x: bmi >= 24.9 ? 8 : bmi < 18.4 ? -8 : 0,y: -5)
                                    
                                    HStack{
                                        VStack{
                                            Text("height(ft)")
                                            Text("\(selectFeet) ft \(selectInch) in").fontWeight(.bold)
                                        }
                                        
                                        VStack{
                                           
                                            Text(String(format: "%.1f", bmi))
                                                .font(.system(size: 12))
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                                .multilineTextAlignment(.center)
                                            Text("BMI")
                                                .font(.system(size: 8))
                                        }.offset(y:-12)
                                        VStack {
                                            Text("weight(lb)")
                                            Text("\(selectlb)").fontWeight(.bold)
                                        }
                                    }  .font(.system(size: 9))
                                }
                                )
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
                    Spacer()
                    
                }.padding(.top)
            }
        }
                
            } .onAppear {
                
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
    
    func lastDayOfPreviousMonth() -> String? {
        let calendar = Calendar.current
        let currentDate = Date()

        guard let lastMonth = calendar.date(byAdding: .month, value: -1, to: currentDate) else {
            return nil
        }

        let lastDayComponents = DateComponents(year: calendar.component(.year, from: lastMonth), month: calendar.component(.month, from: lastMonth) + 1, day: 0)
        let lastDayOfPreviousMonth = calendar.date(from: lastDayComponents)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"

        if let lastDay = lastDayOfPreviousMonth {
            return dateFormatter.string(from: lastDay)
        } else {
            return nil
        }
    }
    
    private func startProgressTimer() {
        var targetProgress: CGFloat = 0.35
        if progress < 0.35 {
                    targetProgress = 0.35
                } else if progress < 0.6 {
                    targetProgress = 0.6
                } else if progress < 0.85 {
                    targetProgress = 0.85
                } else if progress < 1.1 {
                    targetProgress = 1.1
                }
        else {
                    // If progress is greater than or equal to 0.6, do nothing
                    return
                }
        isButtonEnabled = false
        timer = Timer.scheduledTimer(withTimeInterval: 0.005, repeats: true) { _ in
            progress += 0.001
            
            if progress >= targetProgress {
                // Stop the timer when progress reaches 1
                timer?.invalidate()
                isButtonEnabled = true
            }
        }}
    
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

struct Wave: Shape, Animatable {
    var progress: CGFloat
    var waveHeight: CGFloat
    var offset: CGFloat
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get {
            AnimatablePair(progress, offset)
        }
        set {
            progress = newValue.first
            offset = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let progressHeight: CGFloat = (1 - progress) * rect.height
        let height = waveHeight * rect.height
        
        path.move(to: .zero)
        
        for value in stride(from: 0, to: rect.width, by: 2.2) {
            let x: CGFloat = value
            let sine: CGFloat = sin(Angle(degrees: value + offset).radians)
            let y: CGFloat = progressHeight + (height * sine) + 50
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        
        return path
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
        DailyView(selectFeet: .constant(5), selectInch: .constant(7), selectlb: .constant(126))
            
    }
}
