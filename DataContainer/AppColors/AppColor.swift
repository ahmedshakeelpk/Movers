//
//  SignUpScene.swift
//  swiftUIWork
//
//  Created by Shakeel Ahmed on 21/07/2024.
//

import SwiftUI


import SwiftUI


class AppColor {
    static let colorBackGroundGray = Color(hex: "f5f5f5")
    static let colorGrayTextColor = Color(hex: "666666")
    static let colorExtraLightGray = Color(hex: "f5f5f5")
    static let colorBorder = Color(hex: "e0e0e0")
    static let colorDashLine = Color(hex: "d9d9d9")
    static let colorBlack = Color(hex: "202020")
    static let colorTextBlack = Color(hex: "141414")
    static let colorTextPlaceHolder = Color(hex: "d0d0d2")
    static let colorDarkGray = Color(hex: "50525F")
    static let colorMediumGray = Color(hex: "dddddd")

    
    static let colorOrangeOpacity10 = Color(hex: "F19434", opacity: 0.10)
    static let colorOrange = Color(hex: "F19434")

    

    static let colorDarkBlue = Color(hex: "202734")
    static let colorLightGray800 = Color(hex: "F6F6F6")
    static let colorTextFieldBorder = Color(hex: "E8E8E8")
    static let colorLightGreen1000 = Color(hex: "00CC96")
    static let colorDarkOrange = Color(hex: "CB6700")
    static let colorGreen = Color(hex: "00CC96")
    static let colorLightSea = Color(hex: "F2F6F9")
    static let colorLightRed = Color(hex: "EE6266")
}


extension Color {
    init(hex: String, opacity: Double = 1.0) {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int: UInt64 = 0
            Scanner(string: hex).scanHexInt64(&int)
            let r, g, b: Double
            switch hex.count {
            case 3: // RGB (12-bit)
                (r, g, b) = (Double((int >> 8) * 17) / 255.0,
                             Double((int >> 4 & 0xF) * 17) / 255.0,
                             Double((int & 0xF) * 17) / 255.0)
            case 6: // RGB (24-bit)
                (r, g, b) = (Double((int >> 16) & 0xFF) / 255.0,
                             Double((int >> 8) & 0xFF) / 255.0,
                             Double(int & 0xFF) / 255.0)
            default:
                (r, g, b) = (1, 1, 1) // Default to white for invalid hex
            }
            self.init(.sRGB, red: r, green: g, blue: b, opacity: opacity)
        }
}
