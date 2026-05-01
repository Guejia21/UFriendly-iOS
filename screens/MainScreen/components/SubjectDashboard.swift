import SwiftUI


struct SubjectDasboard: View {
    let subjects: [String]  // Ejemplo de materias, debe crearse un modelo de datos para esto
    var body: some View {
        VStack {
            HStack{
                Text("Materias")
                    .font(.title)
                    .fontWeight(.semibold)
                Button("Ver todas"){
                        // Acción para ver todas las materias
                }
            }
            VStack(alignment: .leading, spacing: 16) {
                //Se hace un for para mostrar las 5 primeras materias
                ForEach(0..<5) { index in 
                    SubjectCard(subject: subjects[index])
                }
            }
        }
        .background(.tint, in: RoundedRectangle(cornerRadius: 12))
        .padding()
    }
}

#Preview {
    SubjectDasboard(subjects: ["Matemáticas", "Historia", "Ciencias", "Literatura", "Arte"])
}

struct SubjectCard: View {
    let subject: String
    let horarios: [String] = ["Lunes 10:00 - 11:00", "Miércoles 14:00 - 15:00"] // Ejemplo de horarios, debe crearse un modelo de datos para esto
    var body: some View {
        HStack {
            Text(subject)
                .font(.headline)
            Spacer()
            Image(systemName: "clock")                
            //Recorrer los horarios para mostrarlos
            VStack(alignment: .trailing) {
                ForEach(horarios, id: \.self) { horario in
                Text(horario)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(.white, in: RoundedRectangle(cornerRadius: 12))
    }
}
