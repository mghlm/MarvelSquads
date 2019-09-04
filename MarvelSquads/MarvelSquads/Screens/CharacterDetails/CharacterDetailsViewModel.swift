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
    var dataSource: CharacterDetailsDataSource { get }
}

final class CharacterDetailsViewModel: CharacterDetailsViewModelType {
    
    private var character: Character! {
        didSet {
            setupCallbacks()
            let section = CharacterDetailsSection(character: character)
            dataSource.sections.append(section)
            getComics()
        }
    }
    
    // MARK: - Dependencies
    
    private var apiService: APIServiceType
    var dataSource: CharacterDetailsDataSource
    
    // MARK: - Init
    
    init(character: Character, apiService: APIServiceType, dataSource: CharacterDetailsDataSource) {
        self.apiService = apiService
        self.dataSource = dataSource
        self.set(character)
    }
    
    // MARK: - Public methods
    
    func getComics() {
        if let comics = character.comics {
            let section = ComicDetailsSection(comics: comics)
            dataSource.sections.append(section)
        } else {
            let id = String(character.id)
            apiService.request(type: CharacterComicsResponse.self, endpoint: .getCharacterComics(characterId: id)) { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let comicsResponse):
                    let comics = comicsResponse.data.results
                    if !comics.isEmpty {
                        let section = ComicDetailsSection(comics: comics)
                        self.dataSource.sections.append(section)
                    }
                }
            }
        }
    }
    
    func setupCallbacks() {
        dataSource.didTapAddToSquadButton = { [weak self] in
            guard let self = self else { return }
            print(self.character.isInSquad)
            // change "isInSquad" status of current Character
            // save or remove caracter from storage
        }
    }
    
    // MARK: - Private methods
    
    private func set(_ character: Character) {
        self.character = character
    }
}
