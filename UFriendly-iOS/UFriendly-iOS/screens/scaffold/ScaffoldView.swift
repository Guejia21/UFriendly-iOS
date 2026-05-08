import SwiftUI

struct ScaffoldView: View {
    @State private var selectedTab: AppTab = .home
    @State private var showFABAction = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {

            VStack(spacing: 0) {
                // Top Bar
                TopBarView(title: selectedTab.title)

                // Contenido dinámico 
                ContentAreaView(selectedTab: selectedTab)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                // Bottom Bar
                BottomBarView(selectedTab: $selectedTab)
            }
            .ignoresSafeArea(edges: .bottom)

            // Botón flotante (+)
            FABButton {
                showFABAction = true
            }
            .padding(.trailing, 20)
            .padding(.bottom, 80)
        }
        .sheet(isPresented: $showFABAction) {
            FABSheetView()
        }
    }
}

#Preview {
    ScaffoldView()
}