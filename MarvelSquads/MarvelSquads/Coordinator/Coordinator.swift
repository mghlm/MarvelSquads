//
//  Coordinator.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 02/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var childCoordinators: [String: Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func addChild(coordinator: Coordinator, with key: String)
    func removeChild(coordinator: Coordinator)
}

extension Coordinator {
    func addChild(coordinator: Coordinator, with key: String) {
        childCoordinators[key] = coordinator
    }
    
    func removeChild(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.value !== coordinator}
    }
}
