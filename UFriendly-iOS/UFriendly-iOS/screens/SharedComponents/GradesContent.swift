import SwiftUI

struct GradesContent: View {
    let grades: [Grade]

    var body: some View {
        ForEach(grades, id: \.id) { grade in
            GradeCard(grade: grade)
        }
    }
}
