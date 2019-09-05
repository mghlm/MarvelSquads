//
//  SquadHeaderView.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 05/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class SquadHeaderView: UIView {
    
    // MARK: - Private properties
    
    var squadMembers: [SquadMember] {
        didSet {
            setupUI()
        }
    }
    
    lazy private var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "My Squad"
        
        return lbl
    }()
    
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return cv
    }()
    
    // MARK: - Init
    
    init(frame: CGRect, squadMembers: [SquadMember]) {
        self.squadMembers = squadMembers
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        
        setupConstraints()
    }
    
    private func setupCollectionView() {
        collectionView.register(SquadHeaderCollectionViewCell.self, forCellWithReuseIdentifier: SquadHeaderCollectionViewCell.id)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupConstraints() {
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        collectionView.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 16, paddingRight: 0, width: 0, height: 0)
    }
    
}

extension SquadHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return squadMembers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let squadMember = squadMembers[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquadHeaderCollectionViewCell.id, for: indexPath) as! SquadHeaderCollectionViewCell
        cell.squadMember = squadMember
        return cell
    }
}

