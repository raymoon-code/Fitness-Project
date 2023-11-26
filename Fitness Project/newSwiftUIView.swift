//
//  newSwiftUIView.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/11/23.
//

import SwiftUI

struct newSwiftUIView: View {
    @State private var progress: CGFloat = 0.5
    @State private var offset: CGFloat = 0.0
       @State private var animationDuration: Double = 2.2
    var body: some View {
        Wave(progress: progress, waveHeight: 0.02, offset: offset)
                .fill(Color.blue) // Color of water
                // Adjust the size as needed
                .onAppear {
                    withAnimation(Animation.linear(duration: animationDuration).repeatForever(autoreverses: false)) {
                        progress = 0.6
                        offset = 860// Change the progress value to make the wave move
                    }
                }
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
}

#Preview {
    newSwiftUIView()
}
