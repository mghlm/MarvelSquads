//
//  HomeViewController.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 02/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class HomeViewController: UITableViewController {
    
    //MARK: - Dependencies
    
    private var viewModel: HomeViewModelType!
    
    // MARK: - Init
    
    init(viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        setupCallbacks()
        setupTableView()
        viewModel.loadCharacters()
        super.viewDidLoad()
    }
    
    // MARK: - Private methods
    
    private func setupCallbacks() {
        viewModel.dataSource.didLoadData = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Private methods
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = viewModel.dataSource
        tableView.dataSource = viewModel.dataSource
    }
}

