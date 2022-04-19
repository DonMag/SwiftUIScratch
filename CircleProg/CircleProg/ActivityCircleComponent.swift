//
//  ActivityCircleComponent.swift
//  CircleProg
//
//  Created by Don Mag on 10/19/21.
//

import SwiftUI

/*
struct ActivityCircleComponent: View {
	private let widthOfCircle: CGFloat = 15
	private let headerIconSize = UIScreen.main.bounds.height * 0.03
	private let rotationAmount: Double = 152.5
	private let progress: Double = 0.4
	private let trimAmount: CGFloat = 40
	
	var body: some View {
		GeometryReader { g in
			HStack(alignment: .bottom) {
				ZStack {
					ZStack(alignment: .center) {
						Circle()
							.trim(from: 0.0, to: 0.65)
							.stroke(style: StrokeStyle(lineWidth: self.widthOfCircle, lineCap: .round, lineJoin: .round))
							.foregroundColor(.black)
							.rotationEffect(Angle(degrees: self.rotationAmount))
						
						Circle()
							.trim(from: 0.0, to: CGFloat(self.progress))
							.stroke(style: StrokeStyle(lineWidth: self.widthOfCircle, lineCap: .round, lineJoin: .round))
							.foregroundColor(.red)
							.rotationEffect(Angle(degrees: self.rotationAmount))

						Image("goal")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(height: self.headerIconSize)
							.offset(x: g.size.width * 0.75 * 0.5, y: g.size.width * 0.75 * 0.25)

					}
					.padding([.leading, .top, .trailing], self.widthOfCircle / 2)

					VStack {
						Text("10.000")
							//.font(Fonts.Roboto.bold.of(size: 30))
						
						Text("meters")
							//.font(Fonts.Roboto.light.of(size: 20))
					}

//					ZStack {
//						Image("goal")
//							.resizable()
//							.aspectRatio(contentMode: .fit)
//							.frame(height: self.headerIconSize)
//					}
					
				}
				
			}
			.frame(width: g.size.width * 0.75, height: g.size.width * 0.75)
		}
	}
}
*/

struct ActivityCircleComponent: View {
	
	private let widthOfCircle: CGFloat = 15
	private let headerIconSize = UIScreen.main.bounds.height * 0.03
	private let progress: Double = 0.4
	private let trimAmount: CGFloat = 40
	
	var body: some View {
		HStack(alignment: .bottom) {
			Arc(startAngle: .degrees(0), endAngle: .degrees(220), clockwise: true)
				.stroke(style: StrokeStyle(lineWidth: widthOfCircle, lineCap: .round, lineJoin: .round))
				.frame(width: 300, height: 120)
				.fixedSize()
				.overlay(
					Arc(startAngle: .degrees(0), endAngle: .degrees(progress * 220), clockwise: true)
						.stroke(style: StrokeStyle(lineWidth: widthOfCircle, lineCap: .round, lineJoin: .round))
						.foregroundColor(.red)
						.frame(width: 300, height: 120)
						.fixedSize()
				)
			
			Image(systemName: "rosette")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(height: self.headerIconSize)
			
		}
		.overlay(
			VStack {
				Text("10.000")
				
				Text("meters")
			}
		)
	}
	
}

struct Arc: Shape {
	var startAngle: Angle
	var endAngle: Angle
	var clockwise: Bool
	
	func path(in rect: CGRect) -> Path {
		let rotationAdjustment = Angle.degrees(200)
		let modifiedStart = startAngle - rotationAdjustment
		let modifiedEnd = endAngle - rotationAdjustment
		
		var path = Path()
		path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
		
		return path
	}
}

struct ActivityCircleComponent_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCircleComponent()
    }
}
