import SwiftUI
import ComposableArchitecture
import Combine

struct ProductAddReviewView: View {
    
    @State private var text: String = ""
    @State var rating: Int = 0
    
    @Binding var showRateViewPresented: Bool
    
    let store: Store<ProductAddReviewState, ProductAddReviewAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            let product = viewStore.product
            ZStack {
                ScrollView {
                    VStack {
                        Text("Rate \(product.name)")
                        RatingView(rating: $rating)
                        Text("Tap a star to rate")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.gray)
                        TextEditor(text: $text)
                            .frame(height: 300)
                            .border(.gray)
                        
                        Spacer()
                    }
                    .padding()
                }
                VStack {
                    Spacer()
                    Button {
                        viewStore.send(.addProductReview(productId: product.id, rating: rating, review: text))
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
            .alert(
                store.scope(state: { $0.alert }),
                dismiss: .alertDismissed
            )
        }
    }
}
