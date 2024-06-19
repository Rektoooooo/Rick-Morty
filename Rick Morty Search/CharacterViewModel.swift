//
//  ItemViewModel.swift
//  Fonko fetch
//
//  Created by Sebastián Kučera on 19.06.2024.
//

import Foundation
import Combine

class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var searchText: String = "" {
        didSet {
            if searchText.isEmpty {
                loadCharacters()
            } else {
                searchCharacters(query: searchText)
            }
        }
    }

    private var networkManager = NetworkManager()

    init() {
        networkManager.$characters
            .assign(to: &$characters)
    }

    func loadCharacters() {
        networkManager.fetchData()
    }
    
    func searchCharacters(query: String) {
        networkManager.searchCharacters(query: query)
    }
}
