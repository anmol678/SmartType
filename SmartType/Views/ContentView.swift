//
//  ContentView.swift
//  SmartType
//
//  Created by Anmol Jain on 5/9/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
            PhraseListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let dataManager = DataManager(persistenceController: PersistenceController.preview)
    static var previews: some View {
        ContentView()
            .environmentObject(dataManager)
    }
}

