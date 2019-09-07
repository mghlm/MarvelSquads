//
//  HomeCoordinatorMock.swift
//  MarvelSquadsTests
//
//  Created by Magnus Holm on 07/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit
@testable import MarvelSquads

final class HomeCoordinatorMock: HomeCoordinatorType {
    
    var childCoordinators: [String : Coordinator] = [:]
    var navigationController: UINavigationController
    
    var startCallCount = 0
    var navigateToMoviesCount = 0
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        startCallCount += 1
    }
    
    func navigateToCharacterDetails(with movie: Character) {
        navigateToMoviesCount += 1
    }
}
