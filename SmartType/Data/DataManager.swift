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
    
    public func getAllPhrases() -> [Phrase] {
        let fetchRequest: NSFetchRequest<Phrase> = Phrase.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Phrase.createdAt, ascending: false)]

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch phrases: \(error)")
            return []
        }
    }

    func createPhrase(label: String, content: String) {
        let newPhrase = Phrase(context: context)
        newPhrase.id = UUID()
        newPhrase.label = label
        newPhrase.content = content
        newPhrase.createdAt = Date()
        saveContext()
    }
    
    func updatePhrase(_ phrase: Phrase, label: String, content: String) {
        phrase.label = label
        phrase.content = content
        saveContext()
    }

    func deletePhrase(phrase: Phrase) {
        context.delete(phrase)
        saveContext()
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving phrase: \(error)")
            }
        }
    }
}
