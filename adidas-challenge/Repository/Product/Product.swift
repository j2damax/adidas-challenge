import Foundation

struct Product: Decodable, Equatable, Identifiable {
    let id: String
    let name: String
    let description: String?
    let currency: String?
    let price: Double?
    let imgUrl: String?
}
