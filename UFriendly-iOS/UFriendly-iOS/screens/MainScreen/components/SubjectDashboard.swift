import SwiftUI

struct SubjectDasboard: View {
    let subjects: [Subject]
    let onViewAllClick: () -> Void

    var body: some View {
        VStack {
            HStack {
                Text("Materias")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
                PersonalizedButton(label: "Ver todas") {
                    onViewAllClick()
                }
                .foregroundColor(.white)
            }
            .padding()

            VStack(alignment: .leading, spacing: 16) {
                if subjects.isEmpty {
                    Text("No hay materias registradas")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(Array(subjects.prefix(5)), id: \.id) { subject in
                        SubjectCard(subject: subject)
                    }
                }
            }
            .padding()
        }
        .background(.primaryC, in: RoundedRectangle(cornerRadius: 12))
        .padding()
    }
}

#Preview {
    SubjectDasboard(
        subjects: [
            Subject(name: "Math", teacher: "Prof. Lopez", score: 8.5, completionPercentage: 75, color: "blue"),
            Subject(name: "Science", teacher: "Prof. Perez", score: 9.0, completionPercentage: 80, color: "green"),
        ],
        onViewAllClick: {}
    )
}
