import SwiftUI
import ComposableArchitecture

struct ProductListView: View {
    
    let store: Store<ProductListState, ProductListAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                if true {
                    List {
                        ForEach(viewStore.state.productListModel) { productModel in
                            NavigationLink {
                                //ItemDetails()
                            } label: {
                                ProductsListCell(data: productModel)
                            }
                        }
                        //.searchable(text: $searchText)
                    }
                    .listStyle(.grouped)
                } else {
                    Text("error view")
                }
                Text("Select an item")
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
                reducer: productReducer,
                environment: .dev(environment: ProductListEnvironment(productListRequest: dummyProductListEffect))))
    }
}

