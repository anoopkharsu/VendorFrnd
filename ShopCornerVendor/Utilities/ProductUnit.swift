//
//  ProductUnit.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 10/12/24.
//

enum ProductUnit: String {
    // Weight-Based Units
    case milligram = "mg"
    case gram = "g"
    case kilogram = "kg"
//    case quintal = "quintal"
//    case metricTon = "tonne"
//    case pound = "lb"
//    case ounce = "oz"

    // Volume-Based Units
    case milliliter = "ml"
    case liter = "l"
//    case cubicCentimeter = "cc"
//    case cubicMeter = "m³"
//    case fluidOunce = "fl oz"
//    case gallon = "gallon"
//    case pint = "pt"
//    case quart = "qt"

    // Length-Based Units
//    case millimeter = "mm"
    case centimeter = "cm"
    case meter = "m"
//    case kilometer = "km"
    case inch = "in"
    case foot = "ft"
//    case yard = "yd"
//    case mile = "mi"

    // Area-Based Units
//    case squareMillimeter = "mm²"
//    case squareCentimeter = "cm²"
//    case squareMeter = "m²"
//    case squareKilometer = "km²"
//    case squareInch = "in²"
//    case squareFoot = "ft²"
//    case squareYard = "yd²"
//    case acre = "acre"
//    case hectare = "hectare"

    // Piece/Unit-Based
    case piece = "pcs"
//    case pack = "pack"
//    case dozen = "dozen"
//    case pair = "pair"
//    case box = "box"
//    case crate = "crate"
//    case carton = "carton"
//    case bottle = "bottle"
//    case can = "can"
//    case jar = "jar"
//    case sachet = "sachet"
//    case roll = "roll"
//    case bundle = "bundle"
//    case bag = "bag"
//    case tub = "tub"
//    case bar = "bar"
//    case packet = "packet"

    // Time-Based Units
//    case hour = "hour"
//    case day = "day"
//    case week = "week"
//    case month = "month"
//    case year = "year"

    // Miscellaneous Units
//    case sheet = "sheet"
//    case strip = "strip"
//    case slice = "slice"
//    case drop = "drop"
//    case stick = "stick"
//    case cup = "cup"
    case tray = "tray"

    // Custom or Dynamic Unit
    case custom = "custom"
    
    static var allCases: [String] {
        var cases: [String] = []
        [ProductUnit.milligram, .gram, .kilogram, .milliliter, .liter, .centimeter, .meter, .inch, .foot, .piece, .tray].forEach { unit in
            cases.append(unit.rawValue)
        }
        return cases
    }
}
