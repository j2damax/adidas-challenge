import SwiftUI
import ComposableArchitecture

struct ProductDetailsView: View {
    
    let store: Store<ProductDetailsState, ProductDetailsAction>
    @State private var addAReview = false
    
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
                        List(0 ..< 5) { item in
                            Text("Review \(item)")
                        }
                        .cornerRadius(20)
                        .frame(height: 200)
                    }
                }
                VStack {
                    Spacer()
                    AppButton(buttonTapped: $addAReview)
                }
            }
            .padding()
            .popover(isPresented: $addAReview) {
                ReviewView()
            }
            .onAppear {
                viewStore.send(.fetchProductData)
                viewStore.send(.fetchProductReviews)
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
