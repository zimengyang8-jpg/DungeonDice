//
//  ContentView.swift
//  DungeonDice
//
//  Created by Zimeng Yang on 2/14/26.
//

import SwiftUI

struct ContentView: View {
    enum Dice: Int, CaseIterable, Identifiable {
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        var dieName: String {
            return "\(self)".capitalized
        }
        
        var id: Int { self.rawValue }
        
        var roll: Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    @State private var message: String = "Roll a die!"
    private let diceTypes = [4, 6, 8, 10, 12, 20, 100]
    
    
    var body: some View {
        VStack {
            Text("Dungoen Dice!")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.red)
            
            Spacer()
            
            Text(message)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
            
            Spacer()
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(Dice.allCases) { die in
                    Button("\(die.rawValue)-sided") {
                        message = "You rolled a \(die.roll) on a \(die.dieName)-die."
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

