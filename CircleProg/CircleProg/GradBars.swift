//
//  GradBar.swift
//  CircleProg
//
//  Created by Don Mag on 5/26/21.
//

import SwiftUI

struct GradBars: View {
	
	var maxValue: CGFloat = 10
	
	var val1: CGFloat = 10
	var val2: CGFloat = 9
	var val3: CGFloat = 7.5
	var val4: CGFloat = 5
	var val5: CGFloat = 2
	
	@State var open: Bool = true

	let gradient = LinearGradient(gradient: Gradient(colors: [ Color(UIColor(red: 0.98, green: 0.85, blue: 0.38, alpha: 1.00)) ,
															   Color(UIColor(red: 0.63, green: 0.02, blue: 0.11, alpha: 1.00))]),
								  startPoint: .bottom,
								  endPoint: .top)
	
	var body: some View {
		VStack {
			HStack(alignment: .bottom, spacing: 8, content: {

				Rectangle()
					.fill(gradient)
					.frame(width: 40, height: open ? maxValue * 10 : 0, alignment: .bottom)
					.mask(
						VStack {
							RoundedRectangle(cornerRadius: 5.0).frame(height: val1 * 10)
						}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
					)
				
				Rectangle()
					.fill(gradient)
					.frame(width: 40, height: open ? maxValue * 10 : 0, alignment: .bottom)
					.mask(
						VStack {
							RoundedRectangle(cornerRadius: 5.0).frame(height: val2 * 10)
						}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
					)
				
				Rectangle()
					.fill(gradient)
					.frame(width: 40, height: open ? maxValue * 10 : 0, alignment: .bottom)
					.mask(
						VStack {
							RoundedRectangle(cornerRadius: 5.0).frame(height: val3 * 10)
						}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
					)
				
				Rectangle()
					.fill(gradient)
					.frame(width: 40, height: open ? maxValue * 10 : 0, alignment: .bottom)
					.mask(
						VStack {
							RoundedRectangle(cornerRadius: 5.0).frame(height: val4 * 10)
						}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
					)
				
				Rectangle()
					.fill(gradient)
					.frame(width: 40, height: open ? maxValue * 10 : 0, alignment: .bottom)
					.mask(
						VStack {
							RoundedRectangle(cornerRadius: 5.0).frame(height: val5 * 10)
						}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
					)
				
			})
		}
	}

}

struct GradBars_Previews: PreviewProvider {
    static var previews: some View {
        GradBars()
    }
}
