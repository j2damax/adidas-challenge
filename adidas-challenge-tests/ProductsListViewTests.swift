import XCTest
import ComposableArchitecture
import SwiftUI
import SnapshotTesting

@testable import adidas_challenge

class ProductsListViewTests: XCTestCase {
    
    func testSnapshot() {
        let store = Store(initialState: ProductListState(), reducer: productListReducer, environment: .dev(environment: ProductListEnvironment(productListRequest: dummyProductListEffect)))

        let view = ProductListView(store: store)
        
        let vc = UIHostingController(rootView: view)
        vc.view.frame = UIScreen.main.bounds
        
        assertSnapshot(matching: vc, as: .image)
    }
}
