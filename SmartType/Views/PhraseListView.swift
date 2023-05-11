//
//  PhraseListView.swift
//  SmartType
//
//  Created by Anmol Jain on 5/9/23.
//

import SwiftUI

struct PhraseListView: View {
    
    @EnvironmentObject var dataManager: DataManager
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Phrase.createdAt, ascending: false)],
        animation: .default)
    private var phrases: FetchedResults<Phrase>
    
    @State var showingAddPhrase: Bool = false
    @State var selectedPhrase: Phrase? = nil
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(phrases) { phrase in
                    NavigationLink(value: phrase) {
                        VStack(alignment: .leading) {
                            Text(phrase.label)
                                .font(.headline)
                            Text(phrase.content)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .navigationDestination(for: Phrase.self, destination: { phrase in
                        EditPhraseView(phrase: phrase)
                    })
                }
                .onDelete(perform: deletePhrases)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddPhrase.toggle() }) {
                        Label("Add Phrase", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddPhrase) {
                AddPhraseView()
            }
            .navigationTitle("Phrases")
        }
    }
    
    private func deletePhrases(offsets: IndexSet) {
        withAnimation {
            offsets.map { phrases[$0] }.forEach(dataManager.deletePhrase)
        }
    }
}

//struct PhraseListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhraseListView()
//    }
//}
