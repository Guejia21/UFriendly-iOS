//
//  SearchBar.swift
//  UFriendly-iOS
//
//  Created by MAC13 on 6/05/26.
//

import SwiftUI

struct SearchBar: View {

    @Binding var text: String

    var body: some View {

        HStack {

            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search subjects...", text: $text)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal)
    }
}
