import XCTest
import ComposableArchitecture

@testable import adidas_challenge

class ProductsListReducerTests: XCTestCase {
    
    let testScheduler = DispatchQueue.test
    var currencyFormatter = CurrencyFormatter()
    
    var testProducts: [Product] {
      [
        Product(
            id: "1",
            name: "Dummy Product",
            description: "This is a dummy product without any real information",
            currency: "USD",
            price: 100,
            imgUrl: "")
      ]
    }
    
    func testProductListLoaded() {
        let store = TestStore(
            initialState: ProductListState(),
            reducer: productListReducer,
            environment: SystemEnvironment(
                environment: ProductListEnvironment(productListRequest: dummyProductListEffect),
                mainQueue: { self.testScheduler.eraseToAnyScheduler() },
                decoder: { JSONDecoder() }))
        
        store.send(.onAppear) { state in
            state.isLoading = true
        }
        testScheduler.advance()
        store.receive(.dataLoaded(.success(testProducts))) { state in
            state.isLoading = false
            state.products = self.testProducts.map { product in
                    .init(
                        id: product.id,
                        name: product.name.capitalized,
                        description: product.description ?? "",
                        price: self.currencyFormatter.format(product.price ?? 0.00, currencyCode: product.currency ?? "EUR"),
                        imageURL:product.imgUrl
                    )
            }
        }
    }
}
