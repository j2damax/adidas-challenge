import SwiftUI
import ComposableArchitecture

@main
struct AppMain: App {
    var body: some Scene {
        WindowGroup {
            let env = SystemEnvironment.live(environment: ProductListEnvironment(productListRequest: productListEffect))
            ProductListView(
                store: Store(
                    initialState: ProductListState(),
                    reducer: productListReducer,
                    environment: env))
        }
    }
}
