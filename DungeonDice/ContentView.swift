//
//  ContentView.swift
//  DungeonDice
//
//  Created by Zimeng Yang on 2/14/26.
//

import SwiftUI

struct ContentView: View {
    enum Dice: Int, CaseIterable, Identifiable {
        case d4 = 4
        case d6 = 6
        case d8 = 8
        case d10 = 10
        case d12 = 12
        case d20 = 20
        case d100 = 100
        
        var dieName: String {
            return "\(self)".capitalized
        }
        
        var id: Int { self.rawValue }
        
        var roll: Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    @State private var message: String = "Roll a die!"
    @State private var animationTrigger = false // change when animation should occur
    @State private var isDoneAnimating = true
    @State private var rolls: [Int] = []
    private var grandTotal: Int { rolls.reduce(0, +) } // computational property
    
    var body: some View {
        VStack {
            Text("Dungoen Dice!")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.red)
                        
            GroupBox {
                ForEach(rolls, id: \.self) { roll in
                    Text("\(roll)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Divider()
                
                HStack {
                    Text("TOTAL: \(grandTotal)")
                        .bold()
                        .font(.title2)
                        .monospacedDigit() // only animate on digits
                        .contentTransition(.numericText())
                        .animation(.default, value: grandTotal)
                    
                    Spacer()
                    Button("Clear") {
                        rolls.removeAll()
                    }
                    .buttonStyle(.glass)
                    .tint(.red)
                    .disabled(rolls.isEmpty)
                }
            } label: {
                Text("Session Rolls:")
            }
            
            Spacer()
            
            Text(message)
                .multilineTextAlignment(.center)
                .scaleEffect(isDoneAnimating ? 1.0 : 0.6) // animate to 1.0
                .opacity(isDoneAnimating ? 1.0 : 0.2)
                .font(.title)
                .rotation3DEffect(isDoneAnimating ? .degrees(360) : .degrees(0), axis: (x: 1, y: 0, z: 0)) // flip text effect
                .onChange(of: animationTrigger) {
                    isDoneAnimating = false // set to the beginning false state right away
                    withAnimation(.interpolatingSpring(duration: 0.6, bounce: 0.4)) {
                        isDoneAnimating = true
                    }
                }
            
            Spacer()
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(Dice.allCases) { die in
                    Button("\(die.rawValue)-sided") {
                        let roll = die.roll
                        message = "You rolled a \(roll) on a \(die)."
                        animationTrigger.toggle()
                        rolls.append(roll)
                    }
                    .buttonStyle(.glassProminent)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .tint(.red)
                    .font(.title2)
                }
            }
            
            
        }
        .padding()
        
    }
    
}
#Preview {
    ContentView()
}

