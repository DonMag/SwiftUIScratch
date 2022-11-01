//
//  ImageMaskingView.swift
//  CircleProg
//
//  Created by Don Mag on 10/20/22.
//

import SwiftUI

struct ImageMaskingView: View {
	
	@State var xOff: CGFloat = 20
	@State var yOff: CGFloat = 74

//	let designImage = Image("swiftRed")
	let designImage = Image("design1")
	
	var body: some View {
		
		VStack {
			Image("blankBag")
				.resizable()
				.scaledToFill()
				.aspectRatio(3/(false ? 3 : 4), contentMode: .fit)
				.frame(width: UIScreen.main.bounds.width, alignment: .center)
				.overlay(
					designImage
						.resizable()
						.offset(x: xOff, y: yOff)
						.frame(width: 300, height: 300)
						//.blendMode(.overlay)
						.blendMode(.colorBurn)
				)
				.clipped()
			
//				.overlay(
//					Image("whiteOver")
//						.resizable()
//						.scaledToFill()
//						.blendMode(.darken)
//						//.blendMode(.multiply)
//						//.blendMode(.hardLight)
//						//.blendMode(.softLight)
//				)

				.overlay(
					Image("BagWithCutout")
						.resizable()
						.scaledToFill()
				)
				.onTapGesture {
					xOff = xOff == 20 ? 120 : 20
					yOff = yOff == 74 ? 150 : 74
				}
		}.padding()
		
	}
}

struct ImageMaskingView_Previews: PreviewProvider {
    static var previews: some View {
        ImageMaskingView()
    }
}
