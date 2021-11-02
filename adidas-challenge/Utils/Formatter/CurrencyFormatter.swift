import Foundation

protocol CurrencyFormatterProtocol {
    func format(
        _ value: Double,
        forLocale locale: String,
        currencyCode: String
    ) -> String
}

extension CurrencyFormatterProtocol {
    func format(
        _ value: Double,
        currencyCode: String
    ) -> String {
        format(
            value,
            forLocale: "nl-NL",
            currencyCode: currencyCode
        )
    }
}

final class CurrencyFormatter: CurrencyFormatterProtocol {
    private let numberFormatter: NumberFormatter
    init(numberFormatter: NumberFormatter = .init()) {
        self.numberFormatter = numberFormatter
    }
    func format(
        _ value: Double,
        forLocale localeIdentifier: String,
        currencyCode: String
    ) -> String {
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = currencyCode.isEmpty ? "EUR" : currencyCode
        numberFormatter.locale = Locale(identifier: localeIdentifier)
        guard let formattedValue = numberFormatter.string(for: value) else { return "" }
        return formattedValue
    }
}
