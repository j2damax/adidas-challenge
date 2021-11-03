import ComposableArchitecture
import SwiftUI

func productDetailsEffect(productId: String, decoder: JSONDecoder) -> Effect<Product, APIError> {
    guard let url = URL(string: "http://localhost:3001/product/\(productId)") else {
        fatalError("Error on creating url")
    }
    return URLSession.shared.dataTaskPublisher(for: url)
        .mapError { _ in APIError.downloadError }
        .map { data, _ in data }
        .decode(type: Product.self, decoder: decoder)
        .mapError { _ in APIError.decodingError }
        .eraseToEffect()
}

func dummyProductDetailEffect(decoder: JSONDecoder) -> Effect<Product, APIError> {
    let dummyProduct = Product(
        id: "1",
        name: "Dummy Product",
        description: "This is a dummy product without any real information",
        currency: "USD",
        price: 100,
        imgUrl: "")
    return Effect(value: dummyProduct)
}

func productReviewsEffect(productId: String, decoder: JSONDecoder) -> Effect<[Review], APIError> {
    guard let url = URL(string: "http://localhost:3002/reviews/\(productId)") else {
        fatalError("Error on creating url")
    }

    return URLSession.shared.dataTaskPublisher(for: url)
        .mapError { _ in APIError.downloadError }
        .map { data, _ in data }
        .decode(type: [Review].self, decoder: decoder)
        .mapError { _ in APIError.decodingError }
        .eraseToEffect()
}

func dummyProductReviewsEffect(decoder: JSONDecoder) -> Effect<[Review], APIError> {
    let dummyReview = [Review(productID: "123", rating: 1.0, text: "hello")]
    return Effect(value: dummyReview)
}

