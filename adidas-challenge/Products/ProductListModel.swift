import Foundation

struct ProductListModel: Decodable, Equatable {
    let id: String
    let name: String
    let description: String?
    let currency: String?
    let price: Double?
    let imgUrl: String?
}

extension ProductListModel: Identifiable {
   
}
