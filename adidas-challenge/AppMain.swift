import SwiftUI
import ComposableArchitecture

@main
struct AppMain: App {
    var body: some Scene {
        WindowGroup {
            RootView(
              store: Store(
                initialState: RootState(),
                reducer: rootReducer,
                environment: .live(environment: RootEnvironment())))
        }
    }
}
