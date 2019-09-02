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
    
    // MARK: - Init
    
    init(apiService: APIServiceType, dataSource: HomeViewDataSource) {
        self.apiService = apiService
        self.dataSource = dataSource
        
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
    
    // MARK: - Private methods
    
    private func setupCallbacks() {
        dataSource.loadMoreCharacters = { [weak self] in
            guard let self = self else { return }
            self.loadCharacters()
        }
    }
}
