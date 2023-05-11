//
//  EditPhraseView.swift
//  SmartType
//
//  Created by Anmol Jain on 5/9/23.
//

import SwiftUI

struct EditPhraseView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataManager: DataManager
    
    @State private var label: String
    @State private var content: String
    
    var phrase: Phrase
    
    init(phrase: Phrase) {
        self._label = State(initialValue: phrase.label)
        self._content = State(initialValue: phrase.content)
        self.phrase = phrase
    }
    
    var body: some View {
        VStack {
            PhraseFormView(label: $label, content: $content)
        }
        .navigationBarTitle("Edit Phrase", displayMode: .inline)
        .navigationBarItems(
            trailing: Button("Save") {
                updatePhrase()
            }
            .disabled(label == phrase.label && content == phrase.content)
        )
    }
    
    private func updatePhrase() {
        if label.isEmpty || content.isEmpty {
            return
        }
        
        withAnimation {
            dataManager.updatePhrase(phrase, label: label, content: content)
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}

//struct EditPhraseView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditPhraseView()
//    }
//}
