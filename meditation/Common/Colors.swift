//
//  Colors.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.12.2021.
//

import UIKit

extension UIColor {

    struct Main {
        ///3F4168
        static let primaryViolet = UIColor(netHex: 0x3F4168)
        ///8285C7
        static let borderViolet = UIColor(netHex: 0x8285C7)
        ///8182A4
        static let grayViolet = UIColor(netHex: 0x8182A4)
        ///2C2E54
        static let darkViolet = UIColor(netHex: 0x2C2E54)
        ///B4B7FF
        static let lightViolet = UIColor(netHex: 0xB4B7FF)
        ///3F71F2
        static let primaryLavender = UIColor(netHex: 0x3F71F2)
        ///FCFCFC
        static let darkWhite = UIColor(netHex: 0xFCFCFC)
        ///FCFCFC
        static let lightGray = UIColor(netHex: 0xECECEE)
        ///F94D4D
        static let errorRed = UIColor(netHex: 0xF94D4D)
        ///A5A6C5
        static let tabbarUnactive = UIColor(netHex: 0xA5A6C5)
        ///3E4067
        static let tabbarBackground = UIColor(netHex: 0x3E4067)
        ///ECECEE
        static let textGray = UIColor(netHex: 0xECECEE)
    }

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

