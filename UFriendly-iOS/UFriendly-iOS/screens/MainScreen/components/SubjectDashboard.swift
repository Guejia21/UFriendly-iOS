import SwiftUI

struct SubjectDasboard: View {
    let subjects: [Subject]
    let onViewAllClick: () -> Void = {}
    
    var body: some View {
        VStack {
            HStack {
                Text("Materias")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
                PersonalizedButton(label:"Ver todas") {
                    onViewAllClick()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.pink, in: RoundedRectangle(cornerRadius: 12))
            }
            .padding()
            
            VStack(alignment: .leading, spacing: 16) {
                if subjects.isEmpty {
                    Text("No hay materias registradas")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    // Toma los primeros 5 (o menos si no hay 5)
                    ForEach(Array(subjects.prefix(5)), id: \.self) { subject in 
                        SubjectCard(subject: subject)
                    }
                }
            }
            .padding()
        }
        .background(.tint, in: RoundedRectangle(cornerRadius: 12))
        .padding()
    }
}