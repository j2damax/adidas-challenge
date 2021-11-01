import ComposableArchitecture

struct RootState {
  var productListState = ProductListState()
}

enum RootAction {
  case productListAction(ProductListAction)
}

struct RootEnvironment { }

let rootReducer = Reducer<
  RootState,
  RootAction,
  SystemEnvironment<RootEnvironment>
>.combine(
  productReducer.pullback(
    state: \.productListState,
    action: /RootAction.productListAction,
    environment: { _ in .live(environment: ProductListEnvironment(productListRequest: productListEffect)) }))

