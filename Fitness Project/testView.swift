//
//  testView.swift
//  Fitness Project
//
//  Created by Tran Phat on 11/8/23.
//

import SwiftUI
import Firebase

struct testView: View {
    @ObservedObject var model = ViewModeltest()
    
    var body: some View {
        List(model.list){ item in
            Text(item.ref1)
            Text(item.title)
            Text(item.image)
            
        }
    }
    init(){
        model.getData()
    }
}

#Preview {
    testView()
}
