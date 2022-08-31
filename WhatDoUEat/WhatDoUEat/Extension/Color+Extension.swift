//
//  Color+Extension.swift
//  WhatDoUEat
//
//  Created by 김태호 on 2022/08/31.
//

import SwiftUI

extension Color {
    init (hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double((rgb >> 0) & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

extension Color {
    static let mainYellow = Color(hex: "FFD426")
    static let buttonYello = Color(hex: "FEF339")
    static let mainPurple = Color(hex: "264796")
    static let lightYellow = Color(hex: "FFD426").opacity(0.2)
}
