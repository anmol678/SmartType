//
//  TagView.swift
//  SmartType
//
//  Created by Anmol Jain on 5/10/23.
//

import SwiftUI

struct TagView: View {
    
    var data: [String]
    
    var body: some View {
        ScrollView {
            FlexibleView(
                data: data,
                spacing: 8,
                alignment: .leading
            ) { item in
                Text(verbatim: item)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.4))
                    )
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
    }
}
