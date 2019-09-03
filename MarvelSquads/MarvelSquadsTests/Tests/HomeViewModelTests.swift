//
//  HomeViewModelTests.swift
//  MarvelSquadsTests
//
//  Created by Magnus Holm on 03/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import XCTest
@testable import MarvelSquads

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModelType!
    var apiService: APIServiceMock!
    var dataSource: HomeViewDataSource!

    override func setUp() {
        apiService = APIServiceMock()
        dataSource = HomeViewDataSource()
        viewModel = HomeViewModel(apiService: apiService, dataSource: dataSource)
    }

    func testLoadCharactersIsCalledAndResponseIsSuccess() {
        viewModel.loadCharacters()
        
        guard !dataSource.characters.isEmpty else {
            XCTFail("Character collection is empty")
            return
        }
        
        let character = dataSource.characters[0]
        
        XCTAssertEqual(character.id, 123)
        XCTAssertEqual(character.name, "Hulk")
        XCTAssertEqual(character.description, "He's green and strong")
        XCTAssertEqual(character.thumbnail.path, "https://hulkimage.com/hulk")
        XCTAssertEqual(character.thumbnail.extension, "jpg")
        
        XCTAssertEqual(dataSource.characters.count, 2)
    }
    
}




