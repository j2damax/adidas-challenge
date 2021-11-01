import ComposableArchitecture

struct ProductDetailsState: Equatable {
    var product: Product
    var reviews: [Review] = [Review]()
    var isLoading = false
    var apiError: APIError?
}

enum ProductDetailsAction: Equatable {
    case fetchProductData
    case productDataLoaded(Result<Product, APIError>)
    case fetchProductReviews
    case reviewsDataLoaded(Result<[Review], APIError>)
    case addProductReviews
}

struct ProductDetailsEnvironment {
    var productDetailRequest: (JSONDecoder) -> Effect<Product, APIError>
    var productReviewsRequest: (JSONDecoder) -> Effect<[Review], APIError>
}

let productDetailsReducer = Reducer<ProductDetailsState, ProductDetailsAction, SystemEnvironment<ProductDetailsEnvironment>> { state, action, environment in

    switch action {
    case .fetchProductData:
        return environment.productDetailRequest(environment.decoder())
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(ProductDetailsAction.productDataLoaded)
    case .productDataLoaded(let result):
        switch result {
        case .success(let product):
            state.product = product
        case .failure:
            break
        }
        return .none
    case .fetchProductReviews:
        return environment.productReviewsRequest(environment.decoder())
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
    
/*let productDetailsReducer = ProductDetailsReducer { state, action, environment in
    switch action {
    case .loadData:
        state.isLoading = true
        state.apiError = nil
        state.productDetailsModel = nil
        
        return environment.productDetailRequest(environment.decoder())
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(ProductListAction.dataLoaded)

        return environment
            .productsRepository
            .getProductWithID(state.props.productID)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(ProductDetailsAction.loadProductResponse)

    case let .loadProductResponse(.success(data)):
        state.isLoading = false
        state.product = .init(
            name: data.name,
            description: data.description,
            price: environment.currencyFormatter.format(
                data.price,
                currencyCode: data.currency
            ),
            reviews: data.reviews.map { domainObject -> ProductViewData.Review in
                .init(
                    id: environment.generateUUIDString(),
                    flagEmoji: environment.emojiConverter.emojiFlag(for: domainObject.locale),
                    rating: environment.emojiConverter.productRatingStars(for: domainObject.rating),
                    text: domainObject.text
                )
            }
        )
        return .merge(
            .init(
                environment
                    .imagesRepository
                    .getImageDataFromURL(data.imageURL)
                    .receive(on: environment.mainQueue)
                    .eraseToEffect()
                    .map { $0.map(LoadingState.loaded) ?? .empty }
                    .map { .updateProductImageState($0) }
            ),
            .init(value: .fetchProductReviews)
        )

    case let .loadProductResponse(.failure(error)):
        state.isLoading = false
        state.apiError = .init(error)
        return .none

    case let .updateProductImageState(newLoadingState):
        state.productImageState = newLoadingState
        return .none

    case .showAddReviewModal:
        state.isAddReviewModalShown = true
        return .none

    case let .addReviewModalDismissed(shouldUpdateReviews):
        state.isAddReviewModalShown = false
        if shouldUpdateReviews {
            return .init(value: .loadData)
        }
        return .none

    case .fetchProductReviews:
        return environment
            .reviewsRepository
            .getReviewsForProductWithID(state.props.productID)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(ProductDetailsAction.fetchProductReviewsResponse)

    case let .fetchProductReviewsResponse(result):
        if case let .success(data) = result, let currentProductData = state.product {
            let reviewModels = data.map { domainObject -> ProductViewData.Review in
                .init(
                    id: environment.generateUUIDString(),
                    flagEmoji: environment.emojiConverter.emojiFlag(for: domainObject.locale),
                    rating: environment.emojiConverter.productRatingStars(for: domainObject.rating),
                    text: domainObject.text
                )
            }
            state.product = .init(
                name: currentProductData.name,
                description: currentProductData.description,
                price: currentProductData.price,
                reviews: currentProductData.reviews + reviewModels
            )
        }
        return .none
    }
}*/
