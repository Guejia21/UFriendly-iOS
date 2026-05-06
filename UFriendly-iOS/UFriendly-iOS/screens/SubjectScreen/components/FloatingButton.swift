//
//  FloatingButton.swift
//  UFriendly-iOS
//
//  Created by MAC13 on 6/05/26.
//

import SwiftUI

struct FloatingButton: View {

    var action: () -> Void

    var body: some View {

        Button(action: action) {

            Image(systemName: "plus")
                .font(.title)
                .foregroundColor(.black)
                .frame(width: 60, height: 60)
                .background(Color.pink.opacity(0.5))
                .clipShape(Circle())
                .shadow(radius: 5)
        }
    }
}
