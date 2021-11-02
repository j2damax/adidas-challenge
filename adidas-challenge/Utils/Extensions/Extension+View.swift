import SwiftUI

public extension View {
    @ViewBuilder func shimmering(
        active: Bool = true) -> some View {
        if active {
            modifier(Shimmer())
        } else {
            self
        }
    }
}
