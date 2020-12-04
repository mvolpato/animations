//
//  ContentView.swift
//  Animations
//
//  Created by Michele Volpato on 03/12/2020.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var restingSpot = CGSize.zero

    @State private var isShowing = false

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num) / 20))
            }
        }
        .gesture(
            DragGesture()
                .onChanged {
                    let newWidth = self.restingSpot.width + $0.translation.width
                    let newHeight = self.restingSpot.height + $0.translation.height
                    self.dragAmount = CGSize(width: newWidth, height: newHeight) }
                .onEnded { _ in
                    self.restingSpot = self.dragAmount
                    self.enabled.toggle()
                }
        )
        Spacer()
        if isShowing {
            Rectangle()
                .fill(Color.red)
                .frame(width: 200, height: 200)
                .transition(.pivot)
        }
        Spacer()
        Button(isShowing ? "Hide" : "Show") {
            withAnimation {
                self.isShowing.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
