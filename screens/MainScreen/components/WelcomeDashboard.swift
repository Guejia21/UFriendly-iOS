import SwiftUI


struct WelcomeDashboard: View {
    var body: some View {
        VStack {
            Text("¡Welcome!")
                .font(.title)
                .fontWeight(.semibold)
            VStack(alignment: .leading, spacing: 16) {
                HStack{
                    Text("Resumen de tareas")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Button("Ver todas"){
                        // Acción para ver todas las tareas
                    }
                }
                .padding(.bottom, 8)
                HStack{
                    //Aqui van las tarjetas de pendientes, realizadas y vencidas
                    TaskSummaryCard(title: "Pendientes", count: 5, color: .blue)
                    TaskSummaryCard(title: "Realizadas", count: 10, color: .green)
                    TaskSummaryCard(title: "Vencidas", count: 2, color: .red)
                }
            }
        }
        .background(.tint, in: RoundedRectangle(cornerRadius: 12))
        .padding()
}

#Preview {
    WelcomeDashboard()
}

struct TaskSummaryCard: View {
    let title: String
    let count: Int
    let color: Color

    var body: some View {
        VStack {
            Image(systemName: "pause.fill")
                .font(.largeTitle) // Adjusts the size
                .foregroundColor(color) // Sets the icon color
            Text("\(count)")
                .font(.largeTitle)
                .fontWeight(.bold)                
            Text(title)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.gray, in: RoundedRectangle(cornerRadius: 12))
    }
}
#Preview {
    TaskSummaryCard(title: "Pendientes", count: 5, color: .blue)
}