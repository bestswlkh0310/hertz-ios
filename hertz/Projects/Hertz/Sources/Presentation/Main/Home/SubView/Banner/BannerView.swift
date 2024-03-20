import SwiftUI

struct BannerView: View {
    var body: some View {
        TabView {
            ForEach(0..<3) {
                BannerCell(title: "Page \($0)")
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}
