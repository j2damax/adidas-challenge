import ComposableArchitecture

struct ProductListState: Equatable {
  var productListModel: [ProductListModel] = [ProductListModel]()
}

enum ProductListAction: Equatable {
  case onAppear
  case dataLoaded(Result<[ProductListModel], APIError>)
}

struct ProductListEnvironment {
  var productListRequest: (JSONDecoder) -> Effect<[ProductListModel], APIError>
}

let productListReducer = Reducer<
    ProductListState,
    ProductListAction,
  SystemEnvironment<ProductListEnvironment>
> { state, action, environment in
  switch action {
  case .onAppear:
    return environment.productListRequest(environment.decoder())
      .receive(on: environment.mainQueue())
      .catchToEffect()
      .map(ProductListAction.dataLoaded)
  case .dataLoaded(let result):
    switch result {
    case .success(let products):
      state.productListModel = products
    case .failure:
      break
    }
    return .none
  }
}
