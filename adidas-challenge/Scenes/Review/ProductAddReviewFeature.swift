import Foundation
import ComposableArchitecture

struct ProductAddReviewState: Equatable {
    var product: ProductRow
    var review: Review? = nil
}

enum ProductAddReviewAction: Equatable {
    case addProductReview(productId: String, rating: Int, review: String)
    case reviewDataLoaded(Result<Review, APIError>)
}

struct ProductAddReviewEnvironment {
    var addProductReviewRequest: (_ productID: String, _ params: [String: Any], _ decorder: JSONDecoder) -> Effect<Review, APIError>
}

let productAddReviewReducer = Reducer<ProductAddReviewState, ProductAddReviewAction, SystemEnvironment<ProductAddReviewEnvironment>> { state, action, environment in

    switch action {
    case .addProductReview(let productId, let rating, let review):
        let params: [String: Any] = [
            "productId": productId,
            "locale": "en",
            "rating": rating,
            "text": review
          ]
        
        return environment.addProductReviewRequest(productId, params, environment.decoder())
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(ProductAddReviewAction.reviewDataLoaded)
    case .reviewDataLoaded(let result):
        switch result {
        case .success(let review):
            state.review = review
        case .failure:
            break
        }
        return .none
    }
}
