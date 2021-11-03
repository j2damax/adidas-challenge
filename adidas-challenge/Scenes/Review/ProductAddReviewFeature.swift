import Foundation
import ComposableArchitecture

struct ProductAddReviewState: Equatable {
    var product: ProductRow
    var review: Review? = nil
    var alert: AlertState<ProductAddReviewAction>?
    var reviewCompleted: Bool = false
}

enum ProductAddReviewAction: Equatable {
    case addProductReview(productId: String, rating: Int, review: String)
    case reviewCompleted(Result<Review, APIError>)
    case alertDismissed
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
            .map(ProductAddReviewAction.reviewCompleted)
    case .reviewCompleted(let result):
        switch result {
        case .success(let review):
            state.review = review
            state.alert = .init(
                title: TextState("Review"),
                message: TextState("Success")
            )
        case .failure:
            state.alert = .init(
                title: TextState("Review"),
                message: TextState("Fail")
            )
        }
        return .none
        
    case .alertDismissed:
        state.alert = nil
        state.reviewCompleted = true
        return .none
    }
}
