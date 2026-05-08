import SwiftUI

// MARK: - Tabs disponibles
enum AppTab: CaseIterable {
    case home, search, alerts, profile

    var title: String {
        switch self {
        case .home:    return "Inicio"
        case .search:  return "Buscar"
        case .alerts:  return "Alertas"
        case .profile: return "Perfil"
        }
    }

    var icon: String {
        switch self {
        case .home:    return "house"
        case .search:  return "magnifyingglass"
        case .alerts:  return "bell"
        case .profile: return "person"
        }
    }
}

// MARK: - Scaffold principal
struct ScaffoldView: View {
    @State private var selectedTab: AppTab = .home
    @State private var showFABAction = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {

            VStack(spacing: 0) {
                // ── Top Bar ──────────────────────────────────────────
                TopBarView(title: selectedTab.title)

                // ── Contenido dinámico ───────────────────────────────
                ContentAreaView(selectedTab: selectedTab)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                // ── Bottom Bar ───────────────────────────────────────
                BottomBarView(selectedTab: $selectedTab)
            }
            .ignoresSafeArea(edges: .bottom)

            // ── Botón flotante (+) ───────────────────────────────────
            FABButton {
                showFABAction = true
            }
            .padding(.trailing, 20)
            .padding(.bottom, 80) // encima del BottomBar
        }
        .sheet(isPresented: $showFABAction) {
            FABSheetView()
        }
    }
}

// MARK: - Top Bar
struct TopBarView: View {
    let title: String

    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "chevron.left")
                Text("Atrás")
            }
            .foregroundColor(.accentColor)

            Spacer()

            Text(title)
                .font(.headline)

            Spacer()

            Button(action: {}) {
                Image(systemName: "ellipsis")
            }
            .foregroundColor(.accentColor)
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
        .background(Color(UIColor.systemBackground))
        .overlay(Divider(), alignment: .bottom)
    }
}

// MARK: - Área de contenido dinámico
struct ContentAreaView: View {
    let selectedTab: AppTab

    var body: some View {
        Group {
            switch selectedTab {
            case .home:    HomeView()
            case .search:  SearchView()
            case .alerts:  AlertsView()
            case .profile: ProfileView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemGroupedBackground))
        .transition(.opacity) // animación suave al cambiar de tab
        .animation(.easeInOut(duration: 0.2), value: selectedTab)
    }
}

// MARK: - Bottom Bar
struct BottomBarView: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        HStack {
            ForEach(AppTab.allCases, id: \.self) { tab in
                Spacer()
                BottomTabItem(
                    tab: tab,
                    isSelected: selectedTab == tab
                ) {
                    selectedTab = tab
                }

                Spacer()
            }
        }
        .frame(height: 50)
        .padding(.bottom, 28) // Safe area inferior
        .background(
            Color(UIColor.systemBackground)
                .overlay(Divider(), alignment: .top)
        )
    }
}

struct BottomTabItem: View {
    let tab: AppTab
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: { onTap() }, label: {
            VStack(spacing: 4) {
                Image(systemName: isSelected ? "\(tab.icon).fill" : tab.icon)
                    .font(.system(size: 20))
                Text(tab.title)
                    .font(.caption2)
            }
            .foregroundColor(isSelected ? .accentColor : Color(UIColor.systemGray))
        })
    }
}

// MARK: - Botón flotante (FAB)
struct FABButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.title2.weight(.semibold))
                .foregroundColor(.white)
                .frame(width: 56, height: 56)
                .background(Color.accentColor)
                .clipShape(Circle())
                .shadow(radius: 4, y: 2)
        }
    }
}

// MARK: - Sheet del FAB
struct FABSheetView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            Text("Acción del botón +")
                .navigationTitle("Nueva acción")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cerrar") { dismiss() }
                    }
                }
        }
    }
}

// MARK: - Pantallas (reemplaza con tu contenido real)

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(1...8, id: \.self) { i in
                    CardView(title: "Elemento \(i)", subtitle: "Descripción del elemento \(i)")
                }
            }
            .padding()
        }
    }
}

struct SearchView: View {
    @State private var query = ""
    var body: some View {
        VStack {
            TextField("Buscar...", text: $query)
                .textFieldStyle(.roundedBorder)
                .padding()
            Spacer()
            Text("Resultados de búsqueda")
                .foregroundColor(.secondary)
            Spacer()
        }
    }
}

struct AlertsView: View {
    var body: some View {
        List {
            ForEach(1...5, id: \.self) { i in
                Label("Notificación \(i)", systemImage: "bell.badge")
            }
        }
    }
}

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.accentColor)
            Text("Nombre de Usuario")
                .font(.title2.weight(.semibold))
            Text("usuario@email.com")
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding(.top, 40)
    }
}

// MARK: - Card reutilizable
struct CardView: View {
    let title: String
    let subtitle: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color(UIColor.systemGray3))
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
    }
}

// MARK: - Preview
#Preview {
    ScaffoldView()
}