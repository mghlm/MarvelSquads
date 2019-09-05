//
//  SquadMember+CoreDataProperties.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 04/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//
//

import Foundation
import CoreData


extension SquadMember {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SquadMember> {
        return NSFetchRequest<SquadMember>(entityName: "SquadMember")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var squadMemberDescription: String?
    @NSManaged public var imageUrl: String?
    
}
