import Foundation
import ComposableArchitecture

func productListEffect(decoder: JSONDecoder) -> Effect<[Product], APIError> {
    guard let url = URL(string: "http://localhost:3001/product") else {
        fatalError("Error on creating url")
    }
    return URLSession.shared.dataTaskPublisher(for: url)
        .mapError { _ in APIError.downloadError }
        .map { data, _ in
            data
        }
        .decode(type: [Product].self, decoder: decoder)
        .mapError { _ in APIError.decodingError }
        .eraseToEffect()
}

func dummyProductListEffect(decoder: JSONDecoder) -> Effect<[Product], APIError> {
    let dummyProduct = [Product(
        id: "1",
        name: "Dummy Product",
        description: "This is a dummy product without any real information",
        currency: "USD",
        price: 100,
        imgUrl: "")]
    return Effect(value: dummyProduct)
}
