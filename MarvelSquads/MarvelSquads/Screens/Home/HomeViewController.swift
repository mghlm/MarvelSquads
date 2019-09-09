//
//  HomeViewController.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 02/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    //MARK: - Dependencies
    
    private var viewModel: HomeViewModelType!
    private var tableViewTopAnchor: NSLayoutConstraint!
    
    // MARK: - Private properties
    
    private lazy var headerView: SquadHeaderView! = {
        let hv = SquadHeaderView(frame: .zero, squadMembers: [SquadMember]())
        hv.accessibilityIdentifier = "homeScreenHeaderView"
        
        return hv
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.id)
        tv.accessibilityIdentifier = "homeScreenTableViewIdentifier"
        
        return tv
    }()
    
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
        tableView.backgroundColor = Color.background.value
        setupNavigationBar()
        setupCallbacks()
        setupUI()
        viewModel.loadCharacters()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateHeaderView()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        [headerView, tableView].forEach { view.addSubview($0) }
        updateHeaderView()
        tableView.separatorStyle = .none
        tableView.delegate = viewModel.dataSource
        tableView.dataSource = viewModel.dataSource
        
        setupConstraints()
    }
    
    private func updateHeaderView() {
        viewModel.getSquadMembers { [weak self] squadMembers in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.headerView.squadMembers = squadMembers
                self.tableViewTopAnchor.constant = squadMembers.isEmpty ? 0 : 170
            }
        }
    }
    
    private func setupCallbacks() {
        viewModel.dataSource.didLoadData = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        headerView.didTapSquadMember = { [weak self] squadMember in
            guard let self = self else { return }
            self.viewModel.navigateToCharacterDetails(for: squadMember)
        }
        viewModel.didSendError = { [weak self] error in
            guard let self = self else { return }
            self.showAlert(with: "Error", message: error.localizedDescription, delay: 5)
        }
    }
    
    // MARK: - Private methods
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false 
        navigationController?.navigationBar.barTintColor = Color.background.value
        let headerImage = UIImage(named: "HeaderImage")
        let imageView = UIImageView(image: headerImage)
        navigationItem.titleView = imageView
    }
    
    private func setupConstraints() {
        headerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 170)
        tableView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        tableViewTopAnchor = tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        tableViewTopAnchor.isActive = true
    }
    
    private func showAlert(with title: String, message: String?, delay: Double) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true)
        
        let deadline = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}

