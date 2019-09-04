//
//  HomeViewModel.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 02/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

protocol HomeViewModelType {
    func loadCharacters()
    var dataSource: HomeViewDataSource { get }
}

final class HomeViewModel: HomeViewModelType {
    
    // MARK: - Private properties
    
    private var limit: Int = 20
    private var offset: Int = 0
    private var reachedEndOfCharacters: Bool = false
    private var isLoading: Bool = false
    
    // MARK: - Dependencies
    
    var apiService: APIServiceType
    var dataSource: HomeViewDataSource
    var coordinator: HomeCoordinatorType
    
    // MARK: - Init
    
    init(apiService: APIServiceType, dataSource: HomeViewDataSource, coordinator: HomeCoordinatorType) {
        self.apiService = apiService
        self.dataSource = dataSource
        self.coordinator = coordinator
        
        setupCallbacks()
    }
    
    // MARK: - Public methods
    
    func loadCharacters() {
        guard !reachedEndOfCharacters, !isLoading else { return }
        
        isLoading = true
        
//        apiService.request(endpoint: .getMarvelCharacters(limit: limit, offset: offset)) { result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let characterResponse):
//                guard let characterData = characterResponse["data"] as? JSON,
//                      let jsonArray = characterData["results"] as? [JSON] else { return }
//                var characters = self.createCharacterObjects(with: jsonArray)
//            }
//        }
        
        apiService.request(type: CharactersResponse.self, endpoint: .getMarvelCharacters(limit: limit, offset: offset)) { result in
            switch result {
            case .failure(let error):
                self.isLoading = false
                print(error)
            case .success(let response):
                let characters = response.data.results
                self.dataSource.characters.append(contentsOf: characters)
                self.dataSource.didLoadData?()
                self.isLoading = false
                self.offset += self.limit
            }
        }
    }
    
//        private func createCharacterObjects(with json: [JSON]) -> [Character] {
//            var characters = [Character]()
//            json.forEach {
//                let character = Character()
//                guard
//                    let id = $0["id"] as? Int32,
//                    let name = $0["name"] as? String,
//                    let characterDescription = $0["description"] as? String,
//                    let thumbnail = $0["thumbnail"] as? JSON,
//                    let path = thumbnail["path"] as? String,
//                    let pathExtension = thumbnail["extension"] as? String else { return }
//                
//                character.id = id
//                character.name = name
//                character.characterDescription = characterDescription
//                character.imageUrl = "\(path).\(pathExtension)"
//                
//                characters.append(character)
//            }
//            return characters
//        }
    
    // MARK: - Private methods
    
    private func setupCallbacks() {
        dataSource.loadMoreCharacters = { [weak self] in
            guard let self = self else { return }
            self.loadCharacters()
        }
        dataSource.didTapCell = { [weak self] character in
            guard let self = self else { return }
            self.coordinator.navigateToCharacterDetails(with: character)
        }
    }
}
