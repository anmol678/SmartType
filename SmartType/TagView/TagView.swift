//
//  TagView.swift
//  SmartType
//
//  Created by Anmol Jain on 5/10/23.
//

import SwiftUI

fileprivate struct TagView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var text: String
    
    var body: some View {
        Text(verbatim: text)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(colorScheme == .dark ?
                          Color.gray.opacity(0.5) : Color.white)
                    .compositingGroup()
                    .shadow(color: Color.black.opacity(0.3), radius: 1, x: 0, y: 1)
            )
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(text: "text this dhk")
            .frame(width: 100, height: 40)
    }
}

struct FlexibleTagView: View {
    
    var data: [String]
    
    var body: some View {
        ScrollView {
            FlexibleView(
                data: data,
                spacing: 8,
                alignment: .leading
            ) { item in
                TagView(text: item)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
    }
}
