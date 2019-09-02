//
//  HomeViewDataSource.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 02/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

final class HomeViewDataSource: NSObject {
    
    var didLoadData: (() -> Void)?
    var loadMoreCharacters: (() -> Void)?
    
    // MARK: - Public propreties
    
    var characters = [Character]()
    
}

extension HomeViewDataSource: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        indexPaths.forEach { }
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = characters.count - 1
        
        if indexPath.row == lastElement {
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false 
        }
        
        if indexPath.row == lastElement - 10 {
            loadMoreCharacters?()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = characters[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = character.name
        return cell
    }
}
