import SwiftUI

struct BottomTabItem: View {
    let tab: AppTab
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: isSelected ? "\(tab.icon).fill" : tab.icon)
                    .font(.system(size: 20))
                Text(tab.title)
                    .font(.caption2)
            }
            .foregroundColor(isSelected ? .accentColor : Color(UIColor.systemGray))
        }
    }
}