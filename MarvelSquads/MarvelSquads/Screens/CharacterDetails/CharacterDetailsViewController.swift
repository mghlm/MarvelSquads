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
    
    lazy private var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        
        return sv
    }()
    
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
        setupCallBacks()
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        setupCharacterDetailsView()
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
        scrollView.addSubview(characterDetailsView)
        characterDetailsView.didLoadView = { [weak self] in
            self?.setupConstraints()
        }
        characterDetailsView.fillSuperview()
        characterDetailsView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    private func setupConstraints() {
        characterDetailsView.fillSuperview()
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: scrollView.frame.size.height)
    }
}
