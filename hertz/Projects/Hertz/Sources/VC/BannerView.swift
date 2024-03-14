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

struct BannerCell: View {
    
    var title: String
    @State var size: CGSize? = nil
    
    var body: some View {
        ZStack {
            Image("Dummy")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            if let size = size {
                Image("Dummy")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(16)
                    .frame(width: size.width, height: size.height)
                    .blur(radius: 10)
            }
            Text("막혔던 돈의 에너지가 술술 풀리는 528Hz")
                .font(.system(size: 16))
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white.opacity(0.16)
                    .blur(radius: 12))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .onReadSize {
                    size = $0
                }
                .padding(18)
        }
        .padding(.horizontal, 16)
        .shadow(color: Color(uiColor: .shadow).opacity(0.15), radius: 20, y: 4)
    }
}
