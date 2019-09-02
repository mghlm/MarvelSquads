//
//  AppCoordinator.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 02/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    private var window: UIWindow
    
    var childCoordinators: [String: Coordinator]
    var navigationController: UINavigationController
    var rootViewController: UIViewController {
        return navigationController
    }
    
    init(window: UIWindow) {
        self.childCoordinators = [:]
        self.window = window
        self.navigationController = UINavigationController()
        self.window.rootViewController = rootViewController
    }
    
    func start() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        addChild(coordinator: homeCoordinator, with: "homeCoordinator")
    }
}
