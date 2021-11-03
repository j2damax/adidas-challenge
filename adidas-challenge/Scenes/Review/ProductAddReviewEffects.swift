import Foundation
import ComposableArchitecture

func addProductReviewEffect(productId: String, params: [String: Any], decoder: JSONDecoder) -> Effect<Review, APIError> {
    guard let url = URL(string: "http://localhost:3002/reviews/\(productId)") else {
        fatalError("Error on creating url")
    }
    let data = try? JSONSerialization.data(withJSONObject: params, options: [])
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = data
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    return URLSession.shared.dataTaskPublisher(for: request)
        .mapError { _ in APIError.downloadError }
        .map { data, _ in data
        }
        .decode(type: Review.self, decoder: decoder)
        .mapError { _ in APIError.decodingError }
        .eraseToEffect()
}
