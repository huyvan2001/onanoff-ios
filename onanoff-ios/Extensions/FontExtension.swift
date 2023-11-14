//
//  FontExtension.swift
//  DescendantsDNA
//
//  Created by Oleksii Aharkov on 25.04.2023.
//

import SwiftUI

extension Font {
    
    static func PoppinsNormal_text(_ size:CGFloat) -> Font {
        return .custom("Poppins-Normal", size: size)
    }
    
    static func PoppinsSemiBold_text(_ size:CGFloat) -> Font {
        return .custom("Poppins-SemiBold", size: size)
    }
    
    static func PoppinsMedium_text(_ size:CGFloat) -> Font {
        return .custom("Poppins-Medium", size: size)
    }
    
    static func PoppinsBold_text(_ size:CGFloat) -> Font {
		return .custom("Poppins-Bold", size: size)
    }
    
    static func H1() -> Font {
        return PoppinsBold_text(Vconst.DESIGN_RATIO * 25)
    }
    
    static func H2() -> Font {
        return PoppinsSemiBold_text(Vconst.DESIGN_RATIO * 20)
    }
    
    static func H3() -> Font {
        return PoppinsSemiBold_text(Vconst.DESIGN_RATIO * 17)
    }
    
    static func H4() -> Font {
        return PoppinsSemiBold_text(Vconst.DESIGN_RATIO * 15)
    }
    
    static func H4L() -> Font {
        return PoppinsMedium_text(Vconst.DESIGN_RATIO * 15)
    }
    
    static func PM40() -> Font {
        return PoppinsMedium_text(Vconst.DESIGN_RATIO * 40)
    }
    
    static func PB40() -> Font {
        return PoppinsBold_text(Vconst.DESIGN_RATIO * 40)
    }
    
    static func PB60() -> Font {
        return PoppinsBold_text(Vconst.DESIGN_RATIO * 60)
    }
    
    static func P100() -> Font {
        return PoppinsMedium_text(Vconst.DESIGN_RATIO * 100)
    }
    
    static func Body_dark() -> Font {
        return PoppinsMedium_text(Vconst.DESIGN_RATIO * 15.0)
    }
    
    static func Body_Normal() -> Font {
        return PoppinsNormal_text(Vconst.DESIGN_RATIO * 15)
    }
    
    static func Sub_text() -> Font {
        return PoppinsMedium_text(Vconst.DESIGN_RATIO * 12)
    }
    
    static func Sub_textB() -> Font {
        return PoppinsBold_text(Vconst.DESIGN_RATIO * 12)
    }
    
    static func SignOut_text() -> Font {
        return PoppinsMedium_text(Vconst.DESIGN_RATIO * 17)
    }
    
    
}
