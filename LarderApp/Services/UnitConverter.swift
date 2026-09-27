import Foundation

enum UnitFamily: Equatable { case volume, mass, count, other }

/// Converts between units within the same family (volume<->volume, mass<->mass).
/// Deliberately does NOT guess across families (e.g. cloves -> tsp) — see IngredientMerger.
struct UnitConverter {

    private static let volumeToML: [String: Double] = [
        "tsp": 4.929, "tbsp": 14.787, "cup": 236.588, "ml": 1, "l": 1000, "fl_oz": 29.574
    ]
    private static let massToG: [String: Double] = [
        "g": 1, "kg": 1000, "oz": 28.35, "lb": 453.59
    ]

    static func family(for unit: String) -> UnitFamily {
        let u = unit.lowercased()
        if u.isEmpty { return .count }
        if volumeToML[u] != nil { return .volume }
        if massToG[u] != nil { return .mass }
        return .other   // "clove", "bunch", "head", etc. — unit-specific, not auto-converted
    }

    /// Converts `quantity` from `fromUnit` to `toUnit`. Returns nil if the units
    /// aren't in the same convertible family (caller should treat that as a conflict).
    static func convert(_ quantity: Double, from fromUnit: String, to toUnit: String) -> Double? {
        let f = fromUnit.lowercased(), t = toUnit.lowercased()
        if f == t { return quantity }
        if let a = volumeToML[f], let b = volumeToML[t] { return quantity * a / b }
        if let a = massToG[f], let b = massToG[t] { return quantity * a / b }
        return nil
    }
}
