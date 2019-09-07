//
//  CharacterDetailsViewController.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 03/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class CharacterDetailsTableViewController: UITableViewController {
    
    // MARK: - Dependencies
    
    private var viewModel: CharacterDetailsViewModelType!
    
    // MARK: - Init
    
    init(viewModel: CharacterDetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCallbacks()
        setupTableView()
    }
    
    // MARK: - Private methods
    
    private func setupCallbacks() {
        viewModel.dataSource.didUpdateData = { [weak self] in
            self?.reloadData()
        }
        viewModel.dataSource.didTapSquadButton = { [weak self] in
            guard let self = self else { return }
            if self.viewModel.dataSource.characterIsInSquad {
                self.showAddToSquadAlert()
            } else {
                self.viewModel.addCharacterToSquad {
                    self.viewModel.updateSquadStatus()
                    self.reloadData()
                }
            }
        }
    }
    
    private func showAddToSquadAlert() {
        let alert = UIAlertController(title: "Are you sure you want to fire this character from the squad?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Remove", style: .default, handler: { action in
            self.viewModel.removeCharacterFromSquad()
            self.viewModel.updateSquadStatus()
            self.reloadData()
        }))
        present(alert, animated: true)
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.allowsSelection = false 
        tableView.backgroundColor = Color.background.value
        tableView.separatorStyle = .none 
        tableView.register(CharacterDetailsTableViewCell.self, forCellReuseIdentifier: CharacterDetailsTableViewCell.id)
        tableView.register(ComicsTableViewCell.self, forCellReuseIdentifier: ComicsTableViewCell.id)
        tableView.delegate = viewModel.dataSource
        tableView.dataSource = viewModel.dataSource
        tableView.accessibilityIdentifier = "charactersTableViewIdentifier"
    }
}


