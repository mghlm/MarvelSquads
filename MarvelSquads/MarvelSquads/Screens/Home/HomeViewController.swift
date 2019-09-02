//
//  HomeViewController.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 02/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        view.backgroundColor = .red
        
        let apiService = APIService()
        
        apiService.request(type: CharactersResponse.self, endpoint: .getMarvelCharacters) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                
                
                
                print(response.data.results[1].description)
            }
        }
        
        super.viewDidLoad()
    }
}

