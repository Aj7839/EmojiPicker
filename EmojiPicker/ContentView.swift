//
//  ContentView.swift
//  EmojiPicker
//
//  Created by Alex Wilson  on 14/01/2024.
//
import SwiftUI

enum EmojiCategory: String, CaseIterable {
    case positiveEmotions = "Positive Emotions"
    case neutralEmotions = "Neutral Emotions"
    case animals = "Animals"
    case food = "Food"
    case nature = "Nature"
}

enum Emoji: String, CaseIterable {
    case frog = "🐸"
    case monkey = "🐵"
    case monkeyHiding = "🙈"
    case monkeyListening = "🙉"
    case happyFace = "😀"
    case phewFace = "😅"
    case kissFace = "😘"
    case heartEyesFace = "😍"
    case cat = "😺"
    case dog = "🐶"
    case thumbsUp = "👍"
    case pizza = "🍕"
    case sun = "☀️"
    case moon = "🌙"
    case star = "⭐️"
    case rainbow = "🌈"
    case flower = "🌺"
    case coffee = "☕️"
    case car = "🚗"
    case airplane = "✈️"
    case musicNote = "🎵"
    case fire = "🔥"
}

struct ContentView: View {
    @State private var searchText = ""
    @State private var selectedEmoji: Emoji? = Emoji.frog

    var filteredEmojis: [Emoji] {
        Emoji.allCases.filter { emoji in
            searchText.isEmpty || emoji.rawValue.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Text(selectedEmoji?.rawValue ?? "")
                    .font(.system(size: 100))
                    .frame(maxWidth: .infinity, alignment: .center)

                if let selectedEmoji = selectedEmoji {
                    Text(selectedEmoji.category().rawValue)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 10)
                }

                TextField("Search Emoji", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                ScrollView {
                    ScrollViewReader { scrollView in
                        VStack {
                            ForEach(filteredEmojis, id: \.self) { emoji in
                                Button(action: {
                                    selectedEmoji = emoji
                                }) {
                                    Text(emoji.rawValue)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                                .tag(emoji)
                                .accessibility(label: Text(emoji.rawValue))
                            }
                        }
                        .onChange(of: searchText) { _ in
                            // Scroll to the top when the search text changes
                            withAnimation {
                                scrollView.scrollTo(Emoji.frog, anchor: .top)
                            }
                        }
                    }
                }

                Spacer()
            }
            .navigationTitle("Emoji Picker V2")
            .padding()
        }
    }
}

extension Emoji {
    func category() -> EmojiCategory {
        switch self {
        case .happyFace, .kissFace, .heartEyesFace, .thumbsUp:
            return .positiveEmotions
        case .phewFace:
            return .neutralEmotions
        case .frog, .monkey, .monkeyHiding, .monkeyListening, .cat, .dog:
            return .animals
        case .pizza:
            return .food
        case .sun, .moon, .star, .rainbow, .flower:
            return .nature
        case .coffee, .car, .airplane, .musicNote, .fire:
            return .positiveEmotions
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
