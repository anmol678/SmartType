//
//  PhraseFormView.swift
//  SmartType
//
//  Created by Anmol Jain on 5/9/23.
//

import SwiftUI

struct PhraseFormView: View {
    @Binding var label: String
    @Binding var content: String
    
    var body: some View {
        Form {
            Section {
                TextField("Label", text: $label)
                    .autocapitalization(.words)
                TextField("Content", text: $content)
            }
        }
    }
}

//struct PhraseFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhraseFormView()
//    }
//}
