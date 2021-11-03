import Foundation

struct Review: Decodable, Equatable {
    let productID: String
    let rating: Double?
    let text: String?

    enum CodingKeys: String, CodingKey {
        case text, rating
        case productID = "productId"
    }
}

extension Review: Identifiable {
    var id: String { productID }
}

