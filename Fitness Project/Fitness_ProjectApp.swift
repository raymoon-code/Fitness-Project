//
//  Fitness_ProjectApp.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/10/23.
//

import SwiftUI

@main
struct Fitness_ProjectApp: App {
 
    @State var selectFeet: Int = 0
    @State var selectInch: Int = 0
    @State var selectlb: Int = 0
    var body: some Scene {
        WindowGroup {
            ContentView(selectFeet: $selectFeet, selectInch: $selectInch, selectlb: $selectlb)
        }
    }
}
