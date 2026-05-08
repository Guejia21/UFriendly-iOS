//
//  SubjectScreen.swift
//  UFriendly-iOS
//
//  Created by MAC13 on 6/05/26.
//

import SwiftUI

struct SubjectsView: View {

    @State private var searchText = ""

    let subjects = [
        Subject(
            name: "Matemáticas",
            teacher: "Prof. Cristian Figueroa",
            score: 0.0,
            completionPercentage: 0,
            color: "color",
        )
    ]

    var body: some View {

        ZStack(alignment: .bottomTrailing) {

            VStack(spacing: 0) {

                VStack(spacing: 20) {

                    TopBar(title: "Subjects")

                    SearchBar(text: $searchText)

                    SubjectFilterButtons()

                    ScrollView {

                        VStack(spacing: 15) {

                            ForEach(subjects) { subject in

                                SubjectCard(subject: subject)
                            }
                        }
                    }

                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [Color.blue, Color.white],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

                BottomNavigationBar()
            }

            FloatingButton {

                print("Agregar materia")
            }
            .padding()
        }
    }
}

#Preview {
    SubjectsView()
}



/*
import SwiftUI

struct SubjectsView: View {

    @State private var searchText = ""
    @State private var selectedTab = 0

    var body: some View {

        ZStack(alignment: .bottomTrailing) {

            VStack(spacing: 0) {

                // HEADER
                VStack(spacing: 20) {

                    Text("Subjects")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    // SEARCH BAR
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)

                        TextField("Search subjects...", text: $searchText)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)

                    // BUTTONS
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

                    // SUBJECT CARD
                    VStack(alignment: .leading, spacing: 10) {

                        HStack {
                            Text("Matemáticas")
                                .font(.title2)
                                .foregroundColor(.white)

                            Spacer()

                            VStack {
                                Text("0%")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.white)

                                Text("Completed")
                                    .foregroundColor(.white)
                                    .font(.caption)
                            }
                        }

                        Text("Monday: 7:00 AM - 9:00 AM")
                            .foregroundColor(.white)

                        Text("Prof. Cristian Figueroa")
                            .foregroundColor(.white)

                        Text("Score: 0.00")
                            .foregroundColor(.white)
                            .font(.title3)

                    }
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(20)
                    .padding(.horizontal)

                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [Color.blue, Color.white],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

                // TAB BAR
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

            // FLOATING BUTTON
            Button(action: {

            }) {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.pink.opacity(0.5))
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
            .padding()
        }
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

#Preview {
    SubjectsView()
}
*/
