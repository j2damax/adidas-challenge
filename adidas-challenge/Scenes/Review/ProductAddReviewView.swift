import SwiftUI
import ComposableArchitecture

struct ProductAddReviewView: View {
    
    @State private var text: String = ""
    @State var rating: Int = 0
    @State var buttonTapped: Bool = false
    
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
                    AppButton(buttonTapped: $buttonTapped)
                        .disabled(text.isEmpty)
                }
            }
            .padding()
        }
    }
}
