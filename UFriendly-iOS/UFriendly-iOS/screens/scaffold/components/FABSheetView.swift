import SwiftUI

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