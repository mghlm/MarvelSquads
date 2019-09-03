//
//  ComicsView.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 03/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class ComicsView: UIView {
    
    // MARK: - Private properties
    
    private var comics: [Comic]
    
    lazy private var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 28)
        lbl.text = "Last appeared in"
//        lbl.textColor = .white 
        
        return lbl
    }()
    
    lazy private var thumbNailStackView: UIStackView = {
        let sv = UIStackView()
        
        return sv
    }()
    
    lazy private var titlesStackView: UIStackView = {
        let sv = UIStackView()
        
        return sv
    }()
    
    // MARK: - Init
    
    init(frame: CGRect, comics: [Comic]) {
        self.comics = comics
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
    }
}
