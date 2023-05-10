//
//  Phrase+CoreDataProperties.swift
//  SmartType
//
//  Created by Anmol Jain on 5/9/23.
//
//

import Foundation
import CoreData


extension Phrase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Phrase> {
        return NSFetchRequest<Phrase>(entityName: "Phrase")
    }

    @NSManaged public var createdAt: Date
    @NSManaged public var label: String
    @NSManaged public var content: String
    @NSManaged public var id: UUID

}

extension Phrase : Identifiable {

}
