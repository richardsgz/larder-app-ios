import Foundation

extension Double {
    /// Display string for ingredient amounts: whole numbers show without decimals,
    /// otherwise up to 2 decimal places (1.25 -> "1.25", 0.75 -> "0.75", 3.0 -> "3").
    var quantityString: String {
        let rounded = (self * 100).rounded() / 100
        if rounded == rounded.rounded() { return String(Int(rounded)) }
        return String(rounded)
    }
}
