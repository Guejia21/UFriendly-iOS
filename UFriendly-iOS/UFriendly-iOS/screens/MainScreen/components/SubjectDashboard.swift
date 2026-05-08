import SwiftUI


struct SubjectDasboard: View {
    let subjects: [Subject]  // TODO: Ejemplo de materias, debe crearse un modelo de datos para esto
    let onViewAllClick: () -> Void = {} // TODO: Crear la función para esto
    var body: some View {
        VStack {
            HStack(){
                Text("Materias")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
                PersonalizedButton(label:"Ver todas"){
                    onViewAllClick()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.pink, in: RoundedRectangle(cornerRadius: 12))
            }
            .padding()
            VStack(alignment: .leading, spacing: 16) {
                //Se hace un for para mostrar las 5 primeras materias
                ForEach(0..<5) { index in 
                    SubjectCard(subject: subjects[index])
                }
            }
            .padding()
        }
        .background(.tint, in: RoundedRectangle(cornerRadius: 12))
        .padding()
    }
}
/*
#Preview {
    SubjectDasboard(subjects: [
        Subject(name: "Matemáticas", teacher: "Prof. García", score: 8.5, completionPercentage: 75, color: "blue",  schedule:"Lunes 9am 11am"),
        Subject(name: "Historia", teacher: "Prof. López", score: 9.0, completionPercentage: 80, color: "green",schedule:"Lunes 9am 11am"),
        Subject(name: "Ciencias", teacher: "Prof. Martínez", score: 8.0, completionPercentage: 70, color: "yellow",schedule:"Lunes 9am 11am"),
        Subject(name: "Literatura", teacher: "Prof. Rodríguez", score: 9.5, completionPercentage: 85, color: "purple",schedule:"Lunes 9am 11am"),
        Subject(name: "Arte", teacher: "Prof. Sánchez", score: 8.8, completionPercentage: 78, color: "pink",schedule:"Lunes 9am 11am")
    ])
}

 
 
 struct SubjectCard: View {
 let subject: Subject
 let horarios: [String] = ["Lunes 10:00 - 11:00", "Miércoles 14:00 - 15:00"] // Ejemplo de horarios, debe crearse un modelo de datos para esto
 var body: some View {
 HStack {
 Text(subject.name)
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
 */
