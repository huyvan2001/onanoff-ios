//
//  DizygoticShape.swift
//  DescendantsDNA
//
//  Created by Dmytro Davydenko on 09/08/2023.
//

import SwiftUI

struct DizygoticShape: Shape {
	
	
	func path(in rect: CGRect) -> Path {
			var path = Path()

			path.move(to: CGPoint(x: rect.midX, y: rect.minY))
			path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
		    path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
			path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

			return path
		}
}

struct DizygoticShape_Previews: PreviewProvider {
    static var previews: some View {
        DizygoticShape()
			.stroke()
			.frame(width: 200,height:200)
			
    }
}
