//
//  ComicsView.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 03/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class ComicsTableViewCell: UITableViewCell {
    
    // MARK: - Private properties
    
    static var id = "ComicsTableViewCellIdentifier"
    
    var comics: [Comic]! {
        didSet {
            setupUI()
        }
    }
    
    lazy private var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        lbl.textColor = .white 
        lbl.text = "Last appeared in"
        
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
    
    // MARK: - Private methods
    
    private func setupUI() {
        backgroundColor = Color.background.value
        setupTitleLabel()
        [thumbNailStackView, titlesStackView].forEach { addSubview($0) }
        setupThumbnailStackView()
        setupImages()
        setupConstraints()
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
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
        thumbNailStackView.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: ((UIScreen.main.bounds.width - 48) / 2) * 1.41)
    }
}
