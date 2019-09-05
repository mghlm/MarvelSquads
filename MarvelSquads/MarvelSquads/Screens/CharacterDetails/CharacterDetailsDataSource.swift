//
//  CharacterDetailsDataSource.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 04/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class CharacterDetailsDataSource: NSObject {
    
    var didUpdateData: (() -> Void)?
    var didTapSquadButton: (() -> Void)?
    var sections = [Section]() {
        didSet {
            didUpdateData?()
        }
    }
    
    var characterIsInSquad: Bool = false 
}

extension CharacterDetailsDataSource: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        
        switch section.sectionType {
        case .characterDetails:
            let character = (section as! CharacterDetailsSection).character
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailsTableViewCell.id, for: indexPath) as! CharacterDetailsTableViewCell
            cell.character = character
            cell.characterIsInSquad = characterIsInSquad 
            cell.didTapSquadButton = { [weak self] in
                self?.didTapSquadButton?()
            }
            return cell
        case .comicDetails:
            let comics = (section as! ComicDetailsSection).comics
            let cell = tableView.dequeueReusableCell(withIdentifier: ComicsTableViewCell.id, for: indexPath) as! ComicsTableViewCell
            cell.comics = comics
            return cell
        }
    }
}

//extension CharacterDetailsDataSource: CharacterDetailsTableViewCellDelegate {
//    func didTapSquadButton() {
//        self.didTapAddToSquadButton?()
//    }
//}
