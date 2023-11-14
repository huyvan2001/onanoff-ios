//
//  ColorExtensions.swift
//  DescendantsDNA
//
//  Created by Oleksii Aharkov on 25.04.2023.
//

import SwiftUI

extension Color {
    
    init?(_ hex: String) {
       var str = hex
       if str.hasPrefix("#") {
         str.removeFirst()
       }
       if str.count == 3 {
         str = String(repeating: str[str.startIndex], count: 2)
           + String(repeating: str[str.index(str.startIndex, offsetBy: 1)], count: 2)
           + String(repeating: str[str.index(str.startIndex, offsetBy: 2)], count: 2)
       } else if !str.count.isMultiple(of: 2) || str.count > 8 {
         return nil
       }
       guard let color = UInt64(str, radix: 16)
       else {
         return nil
       }
       if str.count == 2 {
         let gray = Double(Int(color) & 0xFF) / 255
         self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)
       } else if str.count == 4 {
         let gray = Double(Int(color >> 8) & 0x00FF) / 255
         let alpha = Double(Int(color) & 0x00FF) / 255
         self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)
       } else if str.count == 6 {
         let red = Double(Int(color >> 16) & 0x0000FF) / 255
         let green = Double(Int(color >> 8) & 0x0000FF) / 255
         let blue = Double(Int(color) & 0x0000FF) / 255
         self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)
       } else if str.count == 8 {
         let red = Double(Int(color >> 24) & 0x000000FF) / 255
         let green = Double(Int(color >> 16) & 0x000000FF) / 255
         let blue = Double(Int(color >> 8) & 0x000000FF) / 255
         let alpha = Double(Int(color) & 0x000000FF) / 255
         self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
       } else {
         return nil
       }
     }
    
    public static var Medium_gray: Color {
        return Color("Medium gray")
    }
    
    public static var Dark_gray: Color {
        return Color("Dark gray")
    }
    
    public static var NewDarkGray: Color {
        return Color("NewDarkGray")
    }
    
    public static var LineColor: Color {
        return Color("LineColor")
    }
    
    public static var Primary_600: Color {
        return Color("Primary 600")
    }
    
    public static var Primary_400: Color {
        return Color("Primary 400")
    }
    
    public static var Primary_500: Color {
        return Color("Primary 500")
    }
    
    public static var Primary_350: Color {
        return Color("Primary 350")
    }

    public static var Primary_300: Color {
        return Color("Primary 300")
    }
    
    //Primary blue 700
    public static var Primary_blue_700: Color {
        return Color("Primary blue 700")
    }
    
    public static var Secondary_500: Color {
        return Color("Secondary 500")
    }
    
    public static var Secondary_600: Color {
        return Color("Secondary 600")
    }
    
    public static var Primary_700: Color {
        return Color("Primary 700")
    }
    
    public static var Black: Color {
        return Color("Black")
    }
    
    public static var ShadowColor: Color {
        return Color("ShadowColor")
    }
    
    public static var ShadowColor1: Color {
        return Color("ShadowColor 1")
    }
    
    public static var Black_01: Color {
        return Color("Black_01")
    }
    
    public static var NotificationColor: Color {
        return Color("Notification")
    }
    
    public static var NotificationYellowColor: Color {
        return Color("Notification yellow")
    }
    
    public static var BGColorLeft: Color {
        return Color("BGColorLeft")
    }
    
    public static var BGColorRight: Color {
        return Color("BGColorRight")
    }
    
    public static var Light_gray: Color {
        return Color("Light gray")
    }
    
    public static var Normal_gray: Color {
        return Color("Normal gray")
    }
    
    public static var Light_red: Color {
        return Color("Light red")
    }
    
    public static var Linear: Color {
        return Color("Linear")
    }
    
    public static var Light_yellow: Color {
        return Color("Light yellow")
    }
    
    public static var Light_green: Color {
        return Color("Light green")
    }
    
    public static var DNA: Color {
        return Color("DNA")
    }
    
    public static var Facebook: Color {
        return Color("Facebook")
    }
}

extension View {
    public func foregroundLinearGradient(
        colors: [Color],
        startPoint: UnitPoint,
        endPoint: UnitPoint) -> some View
    {
        self.overlay {

            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
            .mask(
                self

            )
        }
    }
}
