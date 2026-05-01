import SwiftUI


struct MainScreen: View {
    var body: some View {
        //Se deben poner los argumentos
        VStack {
            WelcomeDashboard()
            Spacer()
            SubjectDashboard()
        }
    }
}


#Preview {
    MainScreen()
}