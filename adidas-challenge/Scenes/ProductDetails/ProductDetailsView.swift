import SwiftUI
import ComposableArchitecture

struct ProductDetailsView: View {
    
    let store: Store<ProductDetailsState, ProductDetailsAction>
    @State private var showRateViewPresented = false
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            let product = viewStore.product
            ZStack {
                ScrollView {
                    VStack {
                        HStack {
                            Text(product.name)
                                .font(.title2)
                            Spacer()
                        }
                        
                        AsyncImageView(imageURL: product.imageURL!)
                            .frame(width: 300, height: 200, alignment: .center)
                            .cornerRadius(10)
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(product.price)
                                }
                            }
                            Spacer()
                            
                        }
                        Text(product.description)
                        let reviews = viewStore.reviews
                        
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(reviews) { review in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.gray.opacity(0.1))
                                    Text(review.text ?? "")
                                        .padding(8)
                                }
                            }
                        }
                    }
                }
                VStack {
                    Spacer()
                    Button {
                        showRateViewPresented = true
                    } label: {
                        Spacer()
                        Text("Add review")
                            .padding(20)
                        Spacer()
                    }
                    .background {
                        Color.orange.opacity(0.8)
                    }
                    .cornerRadius(10)
                }
            }
            .padding()
            .popover(isPresented: $showRateViewPresented) {
                let env = SystemEnvironment.live(environment: ProductAddReviewEnvironment(addProductReviewRequest: addProductReviewEffect))
                
                ProductAddReviewView(showRateViewPresented: $showRateViewPresented, store: Store(initialState: ProductAddReviewState(product: product), reducer: productAddReviewReducer, environment: env))
            }
            .onAppear {
                viewStore.send(.fetchProductData(productId: product.id))
                viewStore.send(.fetchProductReviews(productId: product.id))
            }
        }
    }
}

struct AppButton: View {
    @Binding var buttonTapped: Bool
    var body: some View {
        Button {
            buttonTapped = true
        } label: {
            Spacer()
            Text("Add review")
                .padding(20)
            Spacer()
        }
        .background {
            Color.orange.opacity(0.8)
        }
        .cornerRadius(10)
    }
}
