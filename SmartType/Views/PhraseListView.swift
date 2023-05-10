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
    
    var body: some View {
        List {
            ForEach(phrases) { phrase in
                NavigationLink {
                    Text("Item at \(phrase.id.uuidString)")
                } label: {
                    VStack(alignment: .leading) {
                        Text(phrase.label)
                            .font(.headline)
                        Text(phrase.content)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .onDelete(perform: deletePhrases)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: { showingAddPhrase.toggle() }) {
                    Label("Add Phrase", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddPhrase) {
            AddPhraseView()
        }
        .navigationTitle("All Phrases")
    }
    
    private func deletePhrases(offsets: IndexSet) {
        withAnimation {
            offsets.map { phrases[$0] }.forEach(dataManager.deletePhrase)
        }
    }
}

struct PhraseListView_Previews: PreviewProvider {
    static var previews: some View {
        PhraseListView()
    }
}
