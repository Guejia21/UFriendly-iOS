import SwiftUI
import SwiftData

struct SubjectScreen: View {
    @Query private var allSubjects: [Subject]
    @State private var searchText = ""
    @State private var filterSelected = 0

    private var filteredSubjects: [Subject] {
        let filtered = filterSelected == 0
            ? allSubjects.filter { $0.completionPercentage < 100 }
            : allSubjects.filter { $0.completionPercentage >= 100 }

        if searchText.isEmpty { return filtered }
        return filtered.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        VStack(spacing: 0) {
            SearchBar(text: $searchText)
                .padding(.horizontal)
                .padding(.top, 8)

            SubjectFilterButtons(selected: $filterSelected)
                .padding(.vertical, 8)

            if filteredSubjects.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Image(systemName: "book.slash")
                        .font(.system(size: 48))
                        .foregroundColor(.gray)
                    Text(searchText.isEmpty ? "No subjects yet" : "No subjects found")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredSubjects, id: \.id) { subject in
                            NavigationLink(destination: SubjectDetailScreen(subject: subject)) {
                                SubjectCard(subject: subject)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Subjects")
    }
}

#Preview {
    SubjectScreen()
        .modelContainer(for: [Subject.self, Task.self, ClassSchedule.self, Grade.self], inMemory: true)
}
