//
//  HomeCoordinator.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 02/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

protocol HomeCoordinatorType: Coordinator {
    func navigateToCharacterDetails(with character: Character)
}

final class HomeCoordinator: HomeCoordinatorType {
    
    // MARK: - Public properties
    
    var childCoordinators: [String : Coordinator]
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = [:]
        
        start()
    }
    
    // MARK: - Public methods
    
    func start() {
        let homeViewModel = HomeViewModel(apiService: APIService(), dataSource: HomeViewDataSource(), coordinator: self)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        navigationController.pushViewController(homeViewController, animated: false)
    }
    
    func navigateToCharacterDetails(with character: Character) {
        let characterDetailsViewModel = CharacterDetailsViewModel(character: character, apiService: APIService())
        let characterDetailsViewController = CharacterDetailsViewController(viewModel: characterDetailsViewModel)
        navigationController.pushViewController(characterDetailsViewController, animated: true)
    }
}
