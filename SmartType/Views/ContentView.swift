//
//  ContentView.swift
//  SmartType
//
//  Created by Anmol Jain on 5/9/23.
//

import SwiftUI
import CoreData

/**
 TODO
    1. display label instead of content
    2. long press tag to view content
    3. use toolbar instead for add new phrase
    4. reorder phrases in table view
    5. faceID
 */

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                PhraseListView()
                
//                NavigationLink(destination: ExampleVCWrapper()) {
//                    Text("Example")
//                }
            }
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

