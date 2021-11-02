import SwiftUI
import ComposableArchitecture

struct ProductListView: View {
    
    let store: Store<ProductListState, ProductListAction>
    @State private var searchText = ""

    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                VStack {
                    SearchBar(
                        text: viewStore.binding(
                            get: { $0.searchText },
                            send: { .updateSearchText($0) }
                        )
                    )
                    List {
                        let productRows = getProductRowsData(for: viewStore)
                        ForEach(productRows) { productModel in
                            NavigationLink {
                            } label: {
                                ProductsListCell(data: productModel)
                                    .listRowSeparator(.hidden)
                            }
                        }
                    }
                    .simultaneousGesture(DragGesture().onChanged({ _ in
                        UIApplication.shared.endEditing()
                    }))
                }
                .overlay(LoadingView(isLoading: viewStore.isLoading))
                .navigationBarTitle("adidas")
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
    
    private func getProductRowsData(for viewStore: ViewStore<ProductListState, ProductListAction>) -> [ProductListState.ProductRow] {
        var productRows = viewStore.products
        if viewStore.isFiltering {
            productRows = viewStore.filtered
        }
        return productRows
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(
            store: Store(
                initialState: ProductListState(),
                reducer: productListReducer,
                environment: .dev(environment: ProductListEnvironment(productListRequest: dummyProductListEffect))))
    }
}

