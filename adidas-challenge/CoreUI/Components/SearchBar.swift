import SwiftUI

public struct SearchBar: View {
    
    @Binding public var text: String
    @State private var isEditing = false
    
    public init(text: Binding<String>) {
        _text = text
    }
    
    public var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 16)
                .onTapGesture { isEditing = true }
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 24)
                        Spacer()
                    }
                )
                .overlay(
                    HStack {
                        Spacer()
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 24)
                            .onTapGesture { text = "" }
                            .transition(.move(edge: .trailing))
                            .opacity(text.isEmpty ? 0 : 1)
                    }
                )
            
            if isEditing {
                Button("Cancel") {
                    isEditing = false
                    text = ""
                    UIApplication.shared.endEditing()
                }
                .foregroundColor(.secondary)
                .padding(.trailing, 16)
                .transition(.move(edge: .trailing))
            }
        }
    }
}
