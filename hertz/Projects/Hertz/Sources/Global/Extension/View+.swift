import SwiftUI

extension View {
    @ViewBuilder
    func onReadSize(_ perform: @escaping (CGSize) -> Void) -> some View {
        self.customBackground {
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        }
        .onPreferenceChange(SizePreferenceKey.self, perform: perform)
    }
    
    @ViewBuilder
    func customBackground<V: View>(alignment: Alignment = .center, @ViewBuilder content: () -> V) -> some View {
        self.background(alignment: alignment, content: content)
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
}

extension UIView {
    func roundCorners(cornerRadius: CGFloat, byRoundingCorners: UIRectCorner) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = CACornerMask(rawValue: byRoundingCorners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: byRoundingCorners,
                                    cornerRadii: CGSize(width:cornerRadius, height: cornerRadius))

            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath

            layer.mask = maskLayer
        }
    }
}
