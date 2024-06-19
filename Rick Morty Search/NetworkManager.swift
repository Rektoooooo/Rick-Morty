//
//  NetworkManager.swift
//  Fonko fetch
//
//  Created by Sebastián Kučera on 19.06.2024.
//

import Foundation
import Combine

class NetworkManager: ObservableObject {
    @Published var characters: [Character] = []
    private var cancellable: AnyCancellable?

    func fetchData() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/") else { return }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: RickAndMortyAPIResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Failed to fetch data: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.characters = response.results
            })
    }
    
    func searchCharacters(query: String) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?name=\(query)") else { return }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: RickAndMortyAPIResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Failed to search characters: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.characters = response.results
            })
    }
}
