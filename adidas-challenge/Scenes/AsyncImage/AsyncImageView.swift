import SwiftUI

struct AsyncImageView: View {
    
    let imageURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL), transaction: Transaction(animation: .spring())) { phase in
            switch phase {
            case .empty:
                Color.purple.opacity(0.1)

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()

            case .failure(_):
                Image(systemName: "exclamationmark.icloud")
                    .resizable()
                    .scaledToFit()

            @unknown default:
                Image(systemName: "exclamationmark.icloud")
            }
        }
    }
}
