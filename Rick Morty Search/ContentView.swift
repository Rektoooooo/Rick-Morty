//
//  ContentView.swift
//  Fonko fetch
//
//  Created by Sebastián Kučera on 19.06.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CharacterViewModel()
    var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                NavigationLink(destination: CharacterDetailView(character: character)) {
                    if let url = URL(string: character.image) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .frame(width: 50, height: 50)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    VStack(alignment: .leading) {
                        Text(character.name)
                            .font(.headline)
                        HStack {
                            if character.status == "Alive" {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 10)
                            } else if character.status == "Dead" {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 10)
                            } else {
                                Circle()
                                    .fill(Color.gray)
                                    .frame(width: 10)
                            }
                            Text("\(character.status) - \(character.species)")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Character Search")
            .onAppear {
                viewModel.loadCharacters()
            }
            .searchable(text: $viewModel.searchText)
        }
    }
}

#Preview {
    ContentView()
}
