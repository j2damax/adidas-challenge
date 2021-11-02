import SwiftUI
import ComposableArchitecture

@main
struct AppMain: App {
    var body: some Scene {
        WindowGroup {
            ProductListView(
                store: Store(
                    initialState: ProductListState(),
                    reducer: productListReducer,
                    environment: .live(environment: ProductListEnvironment(productListRequest: productListEffect))))
        }
    }
}
