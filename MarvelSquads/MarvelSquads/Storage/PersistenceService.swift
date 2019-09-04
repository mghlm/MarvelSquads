//
//  PersistenceService.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 04/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation
import CoreData

protocol PersistenceServiceType {
    func insertCharacter(character: Character, completion: @escaping (() -> Void))
}

final class PersistenceService: PersistenceServiceType {
    
    // MARK: - Private properties
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Public methods
    
    func insertCharacter(character: Character, completion: @escaping (() -> Void)) {
        // Check if character already exists
        
        if let characterEntity = NSEntityDescription.insertNewObject(forEntityName: "Character", into: context) as? Character {
            
        }
    }
    
    
    // MARK: - Container
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TrendingMovies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
