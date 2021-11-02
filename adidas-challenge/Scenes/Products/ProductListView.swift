import SwiftUI
import ComposableArchitecture

struct ProductListView: View {
    
    let store: Store<ProductListState, ProductListAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                List {
                    ForEach(viewStore.state.productListModel) { productModel in
                        NavigationLink {
                        } label: {
                            ProductsListCell(data: productModel)
                                .listRowSeparator(.hidden)
                        }
                    }
                    //.searchable(text: $searchText)
                }
                .listStyle(.grouped)
                .overlay(LoadingView(isLoading: viewStore.isLoading))
                .navigationBarHidden(true)
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
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

