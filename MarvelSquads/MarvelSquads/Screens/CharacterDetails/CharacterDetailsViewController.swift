//
//  CharacterDetailsViewController.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 03/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class CharacterDetailsViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private var viewModel: CharacterDetailsViewModelType!
    
    // MARK: - Private properties
    
    private var characterDetailsView: CharacterDetailsView!
    
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
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        characterDetailsView = CharacterDetailsView(frame: .zero, character: viewModel.character)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        characterDetailsView.fillSuperview()
    }
}
