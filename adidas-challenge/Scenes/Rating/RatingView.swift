import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    var body: some View {

        HStack {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: imageRating(index: index))
                    .foregroundColor(.orange)
                    .scaleEffect(1.5)
                    .padding()
                    .onTapGesture {
                        self.rating = index
                    }
            }
        }
    }
    
    private func imageRating(index: Int) -> String {
        return index <= rating ? "star.fill" : "star"
    }
}
