//
//  SubjectFilterButtons.swift
//  UFriendly-iOS
//
//  Created by MAC13 on 6/05/26.
//

import SwiftUI

struct SubjectFilterButtons: View {

    var body: some View {

        HStack(spacing: 20) {

            Button("Cursando") {

            }
            .frame(width: 130, height: 45)
            .background(Color.purple.opacity(0.7))
            .foregroundColor(.white)
            .cornerRadius(12)

            Button("Cursadas") {

            }
            .frame(width: 130, height: 45)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
    }
}
