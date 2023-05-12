//
//  TagView.swift
//  SmartType
//
//  Created by Anmol Jain on 5/10/23.
//

import SwiftUI

fileprivate struct TagView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var phrase: Phrase
    var onTap: (Phrase) -> Void
    
    var body: some View {
        Button {
            onTap(phrase)
        } label: {
            Text(verbatim: phrase.content)
                .foregroundColor(Color(.label))
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorScheme == .dark ?
                              Color.gray.opacity(0.5) : Color.white)
                        .compositingGroup()
                        .shadow(color: Color.black.opacity(0.3), radius: 0, x: 0.1, y: 1.1)
                )
        }
    }
}

struct FlexibleTagView: View {
    
    var data: [Phrase]
    var onTap: (Phrase) -> Void
    
    var body: some View {
        ScrollView {
            FlexibleView(
                data: data,
                spacing: 8,
                alignment: .center
            ) { phrase in
                TagView(phrase: phrase, onTap: onTap)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
    }
}
