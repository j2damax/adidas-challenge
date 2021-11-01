import SwiftUI

struct ProductsListCell: View {
    private let data: Product

    init(
        data: Product
    ) {
        self.data = data
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(data.name)
                    HStack {
                        Text("\(data.currency ?? "") \(data.price ?? 0.0)")
                    }
                }
                Spacer()
                Image(systemName: "flame.circle.fill " )
                    .resizable()
                    .frame(width: 100, height: 100,alignment: .center)
                    .background {
                        Color.gray
                    }
                    .cornerRadius(10)
            }
            Text(data.description ?? "")
                .lineLimit(2)
        }
        .padding()
        .background {
            Color.gray
                .opacity(0.3)
        }
        .cornerRadius(20)
    }
}

struct ProductsListCell_Previews: PreviewProvider {
    static var previews: some View {
        let dummyProduct = Product(
            id: "1",
            name: "Dummy Product",
            description: "This is a dummy product without any real information",
            currency: "USD",
            price: 100,
            imgUrl: "")
        ProductsListCell(data: dummyProduct)
    }
}
