import ComposableArchitecture

struct ProductRow: Identifiable, Equatable {
    let id: String
    let name: String
    let description: String
    let price: String
    let imageURL: String?
}

struct ProductListState: Equatable {
    var products: [ProductRow] = [ProductRow]()
    var filtered: [ProductRow] = [ProductRow]()
    var isLoading = false
    var searchText: String = ""
    var isFiltering: Bool { searchText.count > 0 }
}

enum ProductListAction: Equatable {
    case onAppear
    case dataLoaded(Result<[Product], APIError>)
    case updateSearchText(String)
    case searchProductsByText(String)
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
            state.products = products.map { product in
                    .init(
                        id: product.id,
                        name: product.name.capitalized,
                        description: product.description ?? "",
                        price: environment.currencyFormatter.format(product.price ?? 0.00, currencyCode: product.currency ?? "EUR"),
                        imageURL:product.imgUrl
                    )
            }
        case .failure:
            // MARK: TO DO:Need to handle the error state
            print("error")
        }
        return .none
    case let .updateSearchText(text):
        state.searchText = text
        guard text.count >= 1 else {
            return .none
        }
        return .init(value: .searchProductsByText(text))
    case let .searchProductsByText(text):
        let cleanFilter = text.lowercased()
        let filterResult = state
            .products
            .filter {
                $0.description.lowercased().contains(cleanFilter) ||
                $0.name.lowercased().contains(cleanFilter)
            }
        state.filtered = filterResult.isEmpty ? [ProductRow]() : filterResult
        return .none
    }
}
