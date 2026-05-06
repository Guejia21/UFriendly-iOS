//
//  TopBar.swift
//  UFriendly-iOS
//
//  Created by MAC13 on 6/05/26.
//

import SwiftUI

struct TopBar: View {

    var title: String

    var body: some View {

        Text(title)
            .font(.title2)
            .foregroundColor(.white)
            .padding(.top, 20)
    }
}
