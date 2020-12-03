//
//  ContentView.swift
//  Animations
//
//  Created by Michele Volpato on 03/12/2020.
//

import SwiftUI

struct ContentView: View {

    @State private var animationPulse: CGFloat = 1
    @State private var animationAmount: CGFloat = 1
    @State private var animationRotation = 0.0

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button("Reset") {
                    self.animationAmount = 1
                }
                .padding(40)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.red)
                        .scaleEffect(animationPulse)
                        .opacity(Double(2 - animationPulse))
                        .animation(
                            Animation.easeOut(duration: 1)
                                .repeatForever(autoreverses: false)
                        )
                )
                .onAppear {
                    self.animationPulse = 2
                }
                Button("Rotate") {
                    withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                        self.animationRotation += 360
                    }
                }
                .padding(50)
                .background(Color.purple)
                .foregroundColor(.white)
                .clipShape(Circle())
                .rotation3DEffect(.degrees(animationRotation), axis: (x: 0, y: 1, z: 0))
            }
            Spacer()
            VStack {
                Stepper("Scale amount", value: $animationAmount.animation(
                    Animation.easeInOut(duration: 1)
                        .repeatCount(3, autoreverses: true)
                ), in: 1...3)

                Spacer()
                    .frame(height: 100)

                Button("Grow") {
                    self.animationAmount += 1
                }
                .padding(40)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(animationAmount)
                //                .animation(.easeIn)
            }
            Spacer()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
