import SwiftUI

struct AboutUsScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Image(systemName: "person.3.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    Text("UFriendly")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Version 1.0.0")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 32)

                VStack(alignment: .leading, spacing: 16) {
                    Text("Development Team")
                        .font(.title2)
                        .fontWeight(.semibold)

                    DeveloperCard(
                        initials: "JG",
                        name: "Jonathan David Guejia Burbano",
                        role: "Fullstack Developer"
                    )
                    DeveloperCard(
                        initials: "JC",
                        name: "Jhoan David Chacon",
                        role: "Fullstack Developer"
                    )
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Project Info")
                        .font(.title2)
                        .fontWeight(.semibold)

                    ProjectInfoRow(label: "App", value: "UFriendly")
                    ProjectInfoRow(label: "Version", value: "1.0.0")
                    ProjectInfoRow(label: "University", value: "Universidad del Cauca")
                    ProjectInfoRow(label: "Year", value: "2026")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)

                Spacer()
            }
        }
        .navigationTitle("Credits")
    }
}

struct DeveloperCard: View {
    let initials: String
    let name: String
    let role: String

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 50, height: 50)
                Text(initials)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                Text(role)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct ProjectInfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}
