//
//  HomeViewModel.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 02/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

protocol HomeViewModelType {
    
    /// Fetches the characters
    func loadCharacters()
    
    /// The datasource for the home screen, incl. tableview delegate/datasource methods
    var dataSource: HomeViewDataSource { get }
    
    /// Callback to reload home screen view after data change
    var didUpdateHeaderData: (([SquadMember]) -> Void)? { get set }
    
    /// Completes with potential error as NetworkError
    var didSendError: ((NetworkError) -> Void)? { get set }
    
    /// Gets all squad members from database
    ///
    /// - Parameter completion: completes with array of squadmembers
    func getSquadMembers(completion: @escaping (([SquadMember]) -> Void))
    
    /// Navigate to selected squadmember
    ///
    /// - Parameter squadMember: Selected squadmember
    func navigateToCharacterDetails(for squadMember: SquadMember)
}

final class HomeViewModel: HomeViewModelType {
    
    // MARK: - Private properties
    
    private var limit: Int = 20
    private var offset: Int = 0
    private var reachedEndOfCharacters: Bool = false
    private var isLoading: Bool = false
    
    // MARK: - Public properties
    
    var didUpdateHeaderData: (([SquadMember]) -> Void)?
    var didSendError: ((NetworkError) -> Void)?
    
    // MARK: - Dependencies
    
    var apiService: APIServiceType
    var dataSource: HomeViewDataSource
    var persistenceService: PersistenceServiceType
    var coordinator: HomeCoordinatorType
    
    // MARK: - Init
    
    init(apiService: APIServiceType, dataSource: HomeViewDataSource, persistenceService: PersistenceServiceType, coordinator: HomeCoordinatorType) {
        self.apiService = apiService
        self.dataSource = dataSource
        self.persistenceService = persistenceService
        self.coordinator = coordinator
        
        setupCallbacks()
    }
    
    // MARK: - Public methods
    
    func loadCharacters() {
        guard !reachedEndOfCharacters, !isLoading else { return }
        isLoading = true
        apiService.request(type: CharactersResponse.self, endpoint: .getMarvelCharacters(limit: limit, offset: offset)) { result in
            switch result {
            case .failure(let error):
                self.isLoading = false
                self.didSendError?(error)
            case .success(let response):
                let characters = response.data.results
                self.dataSource.characters.append(contentsOf: characters)
                self.dataSource.didLoadData?()
                self.isLoading = false
                self.offset += self.limit
            }
        }
    }
    
    func getSquadMembers(completion: @escaping (([SquadMember]) -> Void)) {
        persistenceService.fetch(SquadMember.self) { squadMembers in
            completion(squadMembers)
        }
    }
    
    func navigateToCharacterDetails(for squadMember: SquadMember) {
        let character = Character(id: Int(squadMember.id), name: squadMember.name ?? "", description: squadMember.squadMemberDescription ?? "", thumbnail: nil, comics: nil, imageUrl: squadMember.imageUrl, isInSquad: true)
        coordinator.navigateToCharacterDetails(with: character)
    }
    
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
