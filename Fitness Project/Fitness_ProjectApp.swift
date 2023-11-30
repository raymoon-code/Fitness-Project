//
//  Fitness_ProjectApp.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/10/23.
//

import SwiftUI
import Firebase
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct Fitness_ProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var selectFeet: Int = 0
    @State var selectInch: Int = 0
    @State var selectlb: Int = 0
    @State var Name: String = ""
    @State var Email: String = ""
    //@State var profile = Profiles(firstName: "", lastName:"", age: nil, email:"", password:"", startingWeight:0, currentWeight:0)
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView(selectFeet: $selectFeet, selectInch: $selectInch, selectlb: $selectlb, Name: $Name, Email: $Email)
//            ContentView(selectFeet: $selectFeet, selectInch: $selectInch, selectlb: $selectlb, Name: $Name, Email: $Email)
        }
    }
}
