//
//  AddPhraseView.swift
//  SmartType
//
//  Created by Anmol Jain on 5/9/23.
//

import SwiftUI

struct AddPhraseView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataManager: DataManager
    
    @State private var label: String = ""
    @State private var content: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Label", text: $label)
                            .autocapitalization(.words)
                        TextField("Content", text: $content)
                    }
                }
            }
            .navigationBarTitle("Add Phrase", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Done") {
                    addPhrase()
                }
            )
        }
    }
    
    private func addPhrase() {
        if label.isEmpty || content.isEmpty {
            return
        }
        
        withAnimation {
            dataManager.createPhrase(label: label, content: content)
        }
        
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct AddPhraseView_Previews: PreviewProvider {
    static var previews: some View {
        AddPhraseView()
    }
}
