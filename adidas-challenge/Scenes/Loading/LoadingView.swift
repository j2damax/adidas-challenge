import SwiftUI

struct LoadingView: View {
    
    var isLoading: Bool
    
    var body: some View {
        if isLoading {
            Text("adidas")
                .font(.largeTitle)
                .bold()
                .shimmering(active: true)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: true)
    }
}
