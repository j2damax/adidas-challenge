import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: Store<RootState, RootAction>
    @State var isActive: Bool = false
    var body: some View {
        WithViewStore(self.store.stateless) { _ in
            NavigationView {
                VStack {
                    if self.isActive {
                        NavigationLink(
                            destination:  ProductListView(
                                store: store.scope(
                                  state: \.productListState,
                                  action: RootAction.productListAction))
                                .navigationBarTitle("")
                                .navigationBarHidden(true),
                            isActive: .constant(true)
                        ) {
                            EmptyView()
                        }
                    } else {
                        Image("placeholder")
                            .resizable()
                            .frame(width: 200, height: 200, alignment: .center)
                            .scaledToFit()
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let rootView = RootView(
            store: Store(
                initialState: RootState(),
                reducer: rootReducer,
                environment: .dev(environment: RootEnvironment())))
        return rootView
    }
}
