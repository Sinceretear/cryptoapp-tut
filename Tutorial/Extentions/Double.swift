//
//  Double.swift
//  Tutorial
//
//  Created by Hunter Walker on 8/15/21.
//

import Foundation

extension Double {
    /// Converts a Double into a Currency with 2 decimal places
    /// ```
    /// Converts 1234.56 to $1,234.56
    /// ```
    
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current
//        formatter.currencyCode = "usd"
//        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    
    /// Converts a Double into a Currency as a string with 2 decimal places
    /// ```
    /// Converts 1234.56 to "$1,234.56"
    ///
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "0.00"
    }
    
    /// Converts a Double into a Currency with 2-6 decimal places
    /// ```
    /// Converts 1234.56 to $1,234.56
    /// Converts 12.3456 to $12.3456
    /// Converts 0.123456 to $0.123456
    /// ```
    
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current
//        formatter.currencyCode = "usd"
//        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    
    /// Converts a Double into a Currency as a string with 2-6 decimal places
    /// ```
    /// Converts 1234.56 to "$1,234.56"
    /// Converts 12.3456 to "$12.3456"
    /// Converts 0.123456 to "$0.123456"
    ///
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "0.00"
    }
    
    /// Converts a Double into string representation
    /// ```
    /// Converts 1.234.56 to "1.23"
    ///
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    
    /// Converts a Double into string with percent symbol
    /// ```
    /// Converts 1.234.56 to "1.23"
    ///
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
}
