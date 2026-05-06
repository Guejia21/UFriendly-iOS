//
//  SubjectCard.swift
//  UFriendly-iOS
//
//  Created by MAC13 on 6/05/26.
//

import SwiftUI

struct SubjectCard: View {

    let subject: Subject

    var body: some View {

        VStack(alignment: .leading, spacing: 10) {

            HStack {

                Text(subject.name)
                    .font(.title2)
                    .foregroundColor(.white)

                Spacer()

                VStack {

                    Text("\(subject.progress)%")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    Text("Completed")
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }

            Text(subject.schedule)
                .foregroundColor(.white)

            Text(subject.professor)
                .foregroundColor(.white)

            Text("Score: \(subject.score, specifier: "%.2f")")
                .font(.title3)
                .foregroundColor(.white)

        }
        .padding()
        .background(Color.orange)
        .cornerRadius(20)
        .padding(.horizontal)
    }
}
