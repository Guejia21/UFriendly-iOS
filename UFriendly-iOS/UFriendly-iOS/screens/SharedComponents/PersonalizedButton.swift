import SwiftUI


struct PersonalizedButton: View {
    let label: String
    let onClick: () -> Void

    var body: some View {
        Button(label){
            onClick()
        }
        .padding()
        .foregroundColor(.black)
        .background(.tertiaryContainer, in: RoundedRectangle(cornerRadius: 12))
    }
}
