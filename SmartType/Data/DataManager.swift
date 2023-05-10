//
//  DataManager.swift
//  SmartType
//
//  Created by Anmol Jain on 5/9/23.
//

import Foundation
import CoreData

class DataManager: ObservableObject {
    let persistenceController: PersistenceController
    private(set) var context: NSManagedObjectContext

    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
        self.context = persistenceController.container.viewContext
    }

    func createPhrase(label: String, content: String) {
        let newPhrase = Phrase(context: context)
        newPhrase.id = UUID()
        newPhrase.label = label
        newPhrase.content = content
        newPhrase.createdAt = Date()

        do {
            try context.save()
        } catch {
            print("Error saving phrase: \(error)")
        }
    }

    func deletePhrase(phrase: Phrase) {
        context.delete(phrase)

        do {
            try context.save()
        } catch {
            print("Error deleting phrase: \(error)")
        }
    }
}
