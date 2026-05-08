import SwiftUI


struct Button: View {
    let label: String
    let onClick: () -> Void

    var body: some View {
        Button(label){
            onClick()
        }
        .padding()
        .foregroundColor(.white)
        .background(.tertiaryContainer, in: RoundedRectangle(cornerRadius: 12))
    }
}