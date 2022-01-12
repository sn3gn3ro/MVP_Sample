//
//  UIFonts + Custom.swift
//  meditation
//
//  Created by Ilya Medvedev on 25.12.2021.
//

import UIKit


extension UIFont {
    
    struct Basic {
        
        static func latoHairline(size: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Lato-Hairline", size: size) else { fatalError("Cannot create font") }
            return font
        }
        
        static func latoNormal(size: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Lato-Regular", size: size) else { fatalError("Cannot create font") }
            return font
        }
        
        static func latoBold(size: CGFloat) -> UIFont {
            guard let font = UIFont(name: "Lato-Bold", size: size) else { fatalError("Cannot create font") }
            return font
        }
//
//        static func eurostileItalic(size: CGFloat) -> UIFont {
//            guard let font = UIFont(name: "Eurostile-HeaIta", size: size) else { fatalError("Cannot create font") }
//            return font
//        }
//
//        static func eurostileBold(size: CGFloat) -> UIFont {
//            guard let font = UIFont(name: "Eurostile-Bol", size: size) else { fatalError("Cannot create font") }
//            return font
//        }
//
//        static func eurostileHeavy(size: CGFloat) -> UIFont {
//            guard let font = UIFont(name: "Eurostile-Hea", size: size) else { fatalError("Cannot create font") }
//            return font
//        }
//
//        static func eurostileHeavyItalic(size: CGFloat) -> UIFont {
//            guard let font = UIFont(name: "Eurostile-BlaIta", size: size) else { fatalError("Cannot create font") }
//            return font
//        }
        
        
    }
}
