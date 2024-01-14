//
//  ContentView.swift
//  EmojiPicker
//
//  Created by Alex Wilson  on 14/01/2024.
//

import SwiftUI



enum Emoji: String, CaseIterable {
    case frog = "🐸"
    case monkey = "🐵"
    case monkeyhiding = "🙈"
    case monkeylistening = "🙉"
}

struct ContentView: View {
    @State var selection = Emoji.frog

    var body: some View {
        NavigationView {
            VStack {
                Text(selection.rawValue)
                    .font(.system(size: 150))

                Picker("Select Emoji", selection: $selection) {
                    ForEach(Emoji.allCases, id: \.self) { emoji in
                        Text(emoji.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            }
            .navigationTitle("Emoji Picker V1")
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
