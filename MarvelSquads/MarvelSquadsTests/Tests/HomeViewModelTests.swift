//
//  HomeViewModelTests.swift
//  MarvelSquadsTests
//
//  Created by Magnus Holm on 03/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import XCTest
import CoreData
@testable import MarvelSquads

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModelType!
    var apiService: APIServiceMock!
    var dataSource: HomeViewDataSource!
    var persistenceService: PersistenceServiceType!
    var coordinator: HomeCoordinatorType!
    
    var contextMock: NSManagedObjectContext!

    override func setUp() {
        apiService = APIServiceMock()
        dataSource = HomeViewDataSource()
        persistenceService = PersistenceService()
        coordinator = HomeCoordinatorMock(navigationController: UINavigationController())
        viewModel = HomeViewModel(apiService: apiService, dataSource: dataSource, persistenceService: persistenceService, coordinator: coordinator)
        
        contextMock = CoreDataHelpers().contextMock
    }
    
    func testDatasourceSetup() {
        XCTAssertNotNil(viewModel.dataSource)
    }
    
    func testFetchSquadMembersFromStorage() {
        insertSquadMembers()
        let fetchedMembers = fetchSquadMembers()
        XCTAssertTrue(fetchedMembers.count == 3, "Wrong number of members: \(fetchedMembers.count). Should be 3.")
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
        XCTAssertEqual(character.thumbnail?.path, "https://hulkimage.com/hulk")
        XCTAssertEqual(character.thumbnail?.extension, "jpg")
        
        XCTAssertEqual(dataSource.characters.count, 2)
    }
    
    // MARK: - Private methods
    
    private func insertSquadMembers() {
        guard let entity = NSEntityDescription.entity(forEntityName: "SquadMember", in: self.contextMock) else { return }
        for _ in 0...2 {
            let squadMember = SquadMember.init(entity: entity, insertInto: self.contextMock)
            squadMember.id = 123
            squadMember.name = "Hulk"
            squadMember.squadMemberDescription = "He's green"
            squadMember.imageUrl = "https://hulkimage.com/hulk.jpg"
        }
    }
    
    private func fetchSquadMembers() -> [SquadMember] {
        let request: NSFetchRequest<SquadMember> = SquadMember.fetchRequest()
        let results = try! contextMock.fetch(request)
        return results
    }
}
