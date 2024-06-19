//
//  CharacterDetailView.swift
//  Fonko fetch
//
//  Created by Sebastián Kučera on 19.06.2024.
//

import SwiftUI

struct CharacterDetailView: View {
    @State var character:Character
    @StateObject private var viewModel = CharacterViewModel()
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    if let url = URL(string: character.image) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .frame(width: 150, height: 150)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    VStack {
                        Text(character.name)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 30))
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
                        }
                    }
                }
                List {
                    Section("\(character.name)'s Gender : ") {
                        Text(character.gender)
                            .font(.headline)
                    }
                    Section("\(character.name)'s Type : ") {
                        if character.type.isEmpty {
                            Text("unknown")
                        } else {
                            Text(character.type)
                                .font(.headline)
                        }
                    }
                    Section("Last known location : ") {
                        Text(character.location.name)
                            .font(.headline)
                    }
                    Section("\(character.name) origin from : ") {
                        Text(character.origin.name)
                            .font(.headline)
                    }
                }
                Spacer()
            }
        }
    }
}
