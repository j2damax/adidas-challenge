import ComposableArchitecture

struct ProductListState: Equatable {
    var productListModel: [ProductRow] = [ProductRow]()
    var isLoading = false
    
    struct ProductRow: Identifiable, Equatable {
        let id: String
        let name: String
        let description: String
        let price: String
        let imageURL: String?
    }

}

enum ProductListAction: Equatable {
    case onAppear
    case dataLoaded(Result<[Product], APIError>)
}

struct ProductListEnvironment {
    var currencyFormatter = CurrencyFormatter()
    var productListRequest: (JSONDecoder) -> Effect<[Product], APIError>
}

let productListReducer = Reducer<
    ProductListState,
    ProductListAction,
    SystemEnvironment<ProductListEnvironment>
> { state, action, environment in
    switch action {
    case .onAppear:
        state.isLoading = true
        return environment.productListRequest(environment.decoder())
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(ProductListAction.dataLoaded)
    case .dataLoaded(let result):
        state.isLoading = false
        switch result {
        case .success(let products):
            state.productListModel = products.map { product in
                    .init(
                        id: product.id,
                        name: product.name,
                        description: product.description ?? "",
                        price: environment.currencyFormatter.format(product.price ?? 0.00, currencyCode: product.currency ?? "EUR"),
                        imageURL:product.imgUrl
                    )
                }
        case .failure:
            break
        }
        return .none
    }
}
