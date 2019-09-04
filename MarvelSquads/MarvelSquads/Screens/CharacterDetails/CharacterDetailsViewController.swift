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
        setupCharacterDetailsView()
        setupCallBacks()
    }
    
    // MARK: - Private methods
    
    private func setupCallBacks() {
        viewModel.didLoadComics = { [weak self] comics in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.characterDetailsView.comics = comics 
            }
        }
    }
    
    private func setupCharacterDetailsView() {
        characterDetailsView = CharacterDetailsView(frame: .zero, character: viewModel.character)
        view.addSubview(characterDetailsView)
        characterDetailsView.fillSuperview()
    }
    
    
}
