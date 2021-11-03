import SwiftUI

struct ReviewView: View {
    @State private var text: String = "My review"
    @State var rating: Int = 2
    @State var buttonTapped: Bool = false
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Text("Rate this product")
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

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
