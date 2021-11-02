import XCTest
import ComposableArchitecture

@testable import adidas_challenge

class ProductsListReducerTests: XCTestCase {
    
    let testScheduler = DispatchQueue.test
    
    var testProductList: [Product] {
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
        
        store.send(.onAppear)
        testScheduler.advance()
        store.receive(.dataLoaded(.success(testProductList))) { state in
            state.productListModel = self.testProductList
        }
    }
}
