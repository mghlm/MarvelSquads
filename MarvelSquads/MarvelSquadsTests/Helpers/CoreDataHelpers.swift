//
//  CoreDataHelpers.swift
//  MarvelSquadsTests
//
//  Created by Magnus Holm on 07/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import CoreData

class CoreDataHelpers {
    
    lazy var persistanceContainerMock: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TrendingMovies")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        return container
    }()
    
    lazy var contextMock: NSManagedObjectContext = {
        persistanceContainerMock.viewContext
    }()
}
