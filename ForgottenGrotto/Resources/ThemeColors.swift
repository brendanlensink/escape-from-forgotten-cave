//
//  ThemeColors.swift
//  ForgottenGrotto
//
//  Created by Brendan on 2021-08-13.
//

import NiceComponents
import SwiftUI

extension Color {
    static let themeColors = ColorTheme(
        primary: Color(hex: "1F2937"),
        primaryVariant: Color(hex: "1E3A8A"),
        onPrimary: Color(hex: "F3F4F6"),
//        secondary: <#T##Color?#>,
//        secondaryVariant: <#T##Color?#>,
//        onSecondary: <#T##Color?#>,
        background: Color(hex: "1F2937")
//        onBackground: <#T##Color?#>,
//        error: <#T##Color?#>,
//        onError: <#T##Color?#>,
//        surface: <#T##Color?#>,
//        onSurface: <#T##Color?#>
    )
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
