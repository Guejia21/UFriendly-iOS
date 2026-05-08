import SwiftUI

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