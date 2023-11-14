//
//  VConst.swift
//  DescendantsDNA
//
//  Created by Dmytro Davydenko on 21/07/2023.
//

import Foundation
import SwiftUI

extension UIScreen {
    static var height = UIScreen.main.bounds.height
    static var width = UIScreen.main.bounds.width
    static var widthUnit = UIScreen.main.bounds.width/100
    static var heightUnit = UIScreen.main.bounds.height/100
}

struct Vconst {
    static let DESIGN_DEVICE_FRAMESIZE: CGSize = CGSize(width: 390.0, height: 844.0)
    static let DESIGN_RATIO: CGFloat = UIScreen.height / DESIGN_DEVICE_FRAMESIZE.height
    static func raitoWidth(width: CGFloat) -> CGFloat {
        return UIScreen.width * width / 390
    }
    
    struct Padding {
        private static let _base = Vconst.DESIGN_RATIO
        static let large = _base * 32.0
        static let medium = _base * 16.0
        static let small = _base * 8.0
    }
}
