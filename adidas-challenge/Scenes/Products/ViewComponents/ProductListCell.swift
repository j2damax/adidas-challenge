import SwiftUI

struct ProductsListCell: View {
    private let data: ProductListState.ProductRow

    init( data: ProductListState.ProductRow) {
        self.data = data
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(data.name)
                Text(data.description)
                    .font(.body)
                    .foregroundColor(.gray)
                Text(data.price)
                    .bold()
            }
            Spacer()
            AsyncImageView(imageURL: data.imageURL!)
            .frame(width: 100, height: 100)
            .cornerRadius(4)
        }
    }
}

struct ProductsListCell_Previews: PreviewProvider {
    static var previews: some View {
        let dummyProduct = ProductListState.ProductRow(
            id: "1",
            name: "Dummy Product",
            description: "This is a dummy product without any real information",
            price: "EUR 100",
            imageURL: "")
        ProductsListCell(data: dummyProduct)
    }
}
