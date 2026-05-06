//
//  BottomNavigationBar.swift
//  UFriendly-iOS
//
//  Created by MAC13 on 6/05/26.
//

import SwiftUI

struct BottomNavigationBar: View {

    var body: some View {

        HStack {

            tabItem(icon: "house.fill", text: "Home")

            Spacer()

            tabItem(icon: "book.fill", text: "Subjects")

            Spacer()

            tabItem(icon: "checkmark.circle", text: "Tasks")

            Spacer()

            tabItem(icon: "star.fill", text: "Grades")

            Spacer()

            tabItem(icon: "person.3.fill", text: "About us")
        }
        .padding()
        .background(Color.blue)
    }

    func tabItem(icon: String, text: String) -> some View {

        VStack {

            Image(systemName: icon)

            Text(text)
                .font(.caption)
        }
        .foregroundColor(.white)
    }
}
