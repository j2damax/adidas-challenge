import ComposableArchitecture

struct ProductDetailsState: Equatable {
    var product: ProductRow
    var reviews: [Review] = [Review]()
    var isLoading = false
    var apiError: APIError?
}

enum ProductDetailsAction: Equatable {
    case fetchProductData(productId: String)
    case productDataLoaded(Result<Product, APIError>)
    case fetchProductReviews(productId: String)
    case reviewsDataLoaded(Result<[Review], APIError>)
    case addProductReviews
}

struct ProductDetailsEnvironment {
    var currencyFormatter = CurrencyFormatter()
    var productDetailRequest: (String, JSONDecoder) -> Effect<Product, APIError>
    var productReviewsRequest: (String, JSONDecoder) -> Effect<[Review], APIError>
}

let productDetailsReducer = Reducer<ProductDetailsState, ProductDetailsAction, SystemEnvironment<ProductDetailsEnvironment>> { state, action, environment in

    switch action {
    case .fetchProductData(let productId):
        return environment.productDetailRequest(productId, environment.decoder())
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(ProductDetailsAction.productDataLoaded)
    case .productDataLoaded(let result):
        switch result {
        case .success(let product):
            state.product = .init(
                id: product.id,
                name: product.name,
                description: product.description ?? "",
                price: environment.currencyFormatter.format(product.price ?? 0.00, currencyCode: product.currency ?? "EUR"),
                imageURL:product.imgUrl
            )
        case .failure:
            break
        }
        return .none
    case .fetchProductReviews(let productId):
        return environment.productReviewsRequest(productId, environment.decoder())
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(ProductDetailsAction.reviewsDataLoaded)
    case .reviewsDataLoaded(let result):
        switch result {
        case .success(let reviews):
            state.reviews = reviews
        case .failure:
            break
        }
        return .none
    case .addProductReviews:
        return .none
    }
}
    
