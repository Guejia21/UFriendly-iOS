import SwiftUI
import SwiftData

struct GradesScreen: View {
    @Query private var grades: [Grade]
    @Query private var subjects: [Subject]

    @State private var showAddGrade = false

    var body: some View {
        Group {
            if grades.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "star.slash")
                        .font(.system(size: 48))
                        .foregroundColor(.gray)
                    Text("No grades registered")
                        .font(.title3)
                        .foregroundColor(.gray)
                    if !subjects.isEmpty {
                        Text("Add a grade to start tracking your performance")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    } else {
                        Text("Create a subject first")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(subjects) { subject in
                            let subjectGrades = grades.filter { $0.subject?.id == subject.id }
                            if !subjectGrades.isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Circle()
                                            .fill(Color(hex: subject.color))
                                            .frame(width: 10, height: 10)
                                        Text(subject.name)
                                            .font(.headline)
                                        Spacer()
                                        let avg = subjectGrades.reduce(0) { $0 + $1.value * $1.weight }
                                        Text("\(avg, specifier: "%.2f")")
                                            .font(.headline)
                                            .foregroundColor(.blue)
                                    }
                                    .padding(.horizontal)
                                    GradesContent(grades: subjectGrades)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Grades")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { showAddGrade = true }) {
                    Image(systemName: "plus")
                }
                .disabled(subjects.isEmpty)
            }
        }
        .sheet(isPresented: $showAddGrade) {
            NavigationStack {
                AddGradeScreen()
            }
        }
    }
}
