import Foundation

struct Review: Decodable, Equatable {
    let productId: String
    let rating: Double
    let text: String
}

extension Review: Identifiable {
    var id: String { productId }
}
