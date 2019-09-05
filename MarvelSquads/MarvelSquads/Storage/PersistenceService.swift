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
    func insertSquadMember(character: Character, completion: @escaping (() -> Void))
    func removeSquadMember(with id: Int, completion: @escaping (() -> Void))
    func squadMemberExist(with id: Int32) -> Bool
}

final class PersistenceService: PersistenceServiceType {
    
    // MARK: - Private properties
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Public methods
    
    func insertSquadMember(character: Character, completion: @escaping (() -> Void)) {
        if let squadMemberEntity = NSEntityDescription.insertNewObject(forEntityName: "SquadMember", into: context) as? SquadMember {
            squadMemberEntity.id = Int32(character.id)
            squadMemberEntity.name = character.name
            squadMemberEntity.squadMemberDescription = character.description
            squadMemberEntity.imageUrl = "\(character.thumbnail.path ?? "").\(character.thumbnail.extension ?? "")"
            do {
                try context.save()
                completion()
            } catch let error as NSError {
                print("Could not insert. \(error), \(error.userInfo)")
            }
        }
    }
    
    func removeSquadMember(with id: Int, completion: @escaping (() -> Void)) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SquadMember")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        let characters = try! context.fetch(fetchRequest)
        for character in characters {
            context.delete(character)
        }
        do {
            try context.save()
            completion()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    func squadMemberExist(with id: Int32) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SquadMember")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        var count = 0
        
        do {
            count = try context.count(for: fetchRequest)
        } catch let error as NSError {
            print("error executing fetch request: \(error)")
            return false
        }
        return count > 0
    }
    
    
    // MARK: - Container
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MarvelSquads")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
