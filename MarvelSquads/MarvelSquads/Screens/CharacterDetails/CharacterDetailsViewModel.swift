//
//  CharacterDetailsViewModel.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 03/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

protocol CharacterDetailsViewModelType {
    func getComics()
    var character: Character { get }
    var didLoadComics: (([Comic]) -> Void)? { get set }
}

final class CharacterDetailsViewModel: CharacterDetailsViewModelType {
    
    // MARK: - Dependencies
    
    var character: Character
    private var apiService: APIServiceType
    
    // MARK: - Public properties
    
    var didLoadComics: (([Comic]) -> Void)?
    
    // MARK: - Init
    
    init(character: Character, apiService: APIServiceType) {
        self.character = character
        self.apiService = apiService
        
        if character.comics == nil {
            getComics()
        }
    }
    
    // MARK: - Private methods
    
    func getComics() {
        let id = String(character.id)
        apiService.request(type: CharacterComicsResponse.self, endpoint: .getCharacterComics(characterId: id)) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let comicsResponse):
                let comics = comicsResponse.data.results
                self.didLoadComics?(comics)
            }
        }
    }
}
