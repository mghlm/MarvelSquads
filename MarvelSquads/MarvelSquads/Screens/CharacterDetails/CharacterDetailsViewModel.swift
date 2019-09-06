//
//  CharacterDetailsViewModel.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 03/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

protocol CharacterDetailsViewModelType {
    var dataSource: CharacterDetailsDataSource { get }
    func addCharacterToSquad(completion: @escaping (() -> Void))
    func removeCharacterFromSquad()
    func updateSquadStatus()
    func characterIsInSquad() -> Bool
}

final class CharacterDetailsViewModel: CharacterDetailsViewModelType {
    
    // MARK: - Private properties
    
    private var character: Character! {
        didSet {
            dataSource.characterIsInSquad = characterIsInSquad()
            let section = CharacterDetailsSection(character: character)
            dataSource.sections.append(section)
            getComics()
        }
    }
    
    // MARK: - Dependencies
    
    private var apiService: APIServiceType
    private var persistenceService: PersistenceServiceType
    var dataSource: CharacterDetailsDataSource
    
    // MARK: - Init
    
    init(character: Character, apiService: APIServiceType, persistenceService: PersistenceServiceType, dataSource: CharacterDetailsDataSource) {
        self.apiService = apiService
        self.persistenceService = persistenceService
        self.dataSource = dataSource
        
        self.set(character)
    }
    
    // MARK: - Public methods 
    
    func addCharacterToSquad(completion: @escaping (() -> Void)) {
        persistenceService.insertSquadMember(character: self.character, completion: {
            completion()
            print("Inserted \(self.character.name) into storage")
        })
    }
    
    func removeCharacterFromSquad() {
        persistenceService.removeSquadMember(with: character.id, completion: {
            print("Removed \(self.character.name) from storage")
        })
    }
    
    func characterIsInSquad() -> Bool {
        return persistenceService.squadMemberExist(with: Int32(character.id))
    }
    
    func updateSquadStatus() {
        dataSource.characterIsInSquad = characterIsInSquad()
    }
    
    // MARK: - Private methods
    
    private func getComics() {
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
    
    private func set(_ character: Character) {
        self.character = character
    }
}
