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
    
    var didLoadComics: (() -> Void)?
    
    var comics: [Comic]? {
        didSet {
            if let comics = comics, !comics.isEmpty  {
                setupUI()
            } else {
                setupNoComicsLabel()
            }
            didLoadComics?()
        }
    }
    
    lazy private var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        lbl.textColor = .white 
        lbl.text = "Last appeared in"
        
        return lbl
    }()
    
    lazy private var noComicsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Never appeared in a comic"
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    lazy private var firstImageView: ImageLoader = {
        let iv = ImageLoader()
        return iv
    }()
    
    lazy private var secondImageView: ImageLoader = {
        let iv = ImageLoader()
        return iv
    }()
    
    lazy private var thumbNailStackView: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 16
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        
        return sv
    }()
    
    lazy private var titlesStackView: UIStackView = {
        let sv = UIStackView()
        
        return sv
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        backgroundColor = Color.background.value 
        [thumbNailStackView, titlesStackView].forEach { addSubview($0) }
        setupThumbnailStackView()
        setupImages()
        setupConstraints()
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
    }
    
    private func setupNoComicsLabel() {
        addSubview(noComicsLabel)
        noComicsLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16, width: 0, height: 0)
    }
    
    private func setupThumbnailStackView() {
        thumbNailStackView.addArrangedSubview(firstImageView)
        thumbNailStackView.addArrangedSubview(secondImageView)
    }
    
    private func setupImages() {
        if let comics = comics, comics.count > 1 {
            var comicCount = 0
            
            [firstImageView, secondImageView].forEach {
                if let imageUrl = comics[comicCount].thumbnail.imageUrl() {
                    $0.loadImage(with: imageUrl)
                    comicCount += 1
                }
            }
        }
    }
    
    private func setupConstraints() {
        thumbNailStackView.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: ((UIScreen.main.bounds.width - 48) / 2) * 1.41)
        
    }
}
