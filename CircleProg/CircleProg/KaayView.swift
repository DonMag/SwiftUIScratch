//
//  KaayView.swift
//  CircleProg
//
//  Created by Don Mag on 6/10/23.
//

import SwiftUI

struct MyShape : Shape {
	func path(in rect: CGRect) -> Path {
		
		return Path { path in
			path.move(to: .zero)
			path.addLine(to: CGPoint(x: UIScreen.main.bounds.width / 2 - 48, y: 0))

			path.addArc(center: CGPoint(x: UIScreen.main.bounds.width / 2 - 48, y: 10),
						radius: 10,
						startAngle: .degrees(-90),
						endAngle: .degrees(0),
						clockwise: false)

			// need to subtract an additional 10-points
			//	for the 10-point radius
			path.addCurve(to: CGPoint(x: UIScreen.main.bounds.width / 2 + (48 - 10), y: 10),
						  control1: CGPoint(x: UIScreen.main.bounds.width / 2 - 80, y: 105),
						  control2: CGPoint(x: UIScreen.main.bounds.width / 2 + 80, y: 105))

			path.addArc(center: CGPoint(x: UIScreen.main.bounds.width / 2 + 48, y: 10),
						radius: 10,
						startAngle: .degrees(-180),
						endAngle: .degrees(-90),
						clockwise: false)

			path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
			path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 100))
			path.addLine(to: CGPoint(x: 0, y: 100))
			path.addLine(to: .zero)
			path.closeSubpath()
		}

	}
	
}

struct MyShape2 : Shape {
	func path(in rect: CGRect) -> Path {
		
		return Path { path in
			path.move(to: .zero)
			path.addLine(to: CGPoint(x: UIScreen.main.bounds.width / 2 - 48, y: 0))
			
			var pt1: CGPoint = .zero
			var pt2: CGPoint = .zero
			
			pt1 = .init(x: UIScreen.main.bounds.width / 2 - 48 + 10, y: 0)
			pt2 = .init(x: UIScreen.main.bounds.width / 2 - 48 - 10, y: 105)
			path.addArc(tangent1End: pt1, tangent2End: pt2, radius: 10)
			
			let p3 = path.currentPoint!
			path.addCurve(to: CGPoint(x: UIScreen.main.bounds.width - p3.x, y: p3.y),
						  control1: CGPoint(x: UIScreen.main.bounds.width / 2 - 80, y: 105),
						  control2: CGPoint(x: UIScreen.main.bounds.width / 2 + 80, y: 105))
			
			pt1 = .init(x: UIScreen.main.bounds.width / 2 + 48 - 10, y: 0)
			pt2 = .init(x: UIScreen.main.bounds.width / 2 + 48 + 10, y: 0)
			path.addArc(tangent1End: pt1, tangent2End: pt2, radius: 10)
			
			path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
			path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 100))
			path.addLine(to: CGPoint(x: 0, y: 100))
			path.addLine(to: .zero)
			path.closeSubpath()
		}
		
	}
	
}

struct KaayView: View {
    var body: some View {
		VStack {
			MyShape()
				.fill(Color.gray)
			Spacer()
			MyShape2()
				.fill(Color.red)
		}
    }
}

struct KaayView_Previews: PreviewProvider {
    static var previews: some View {
        KaayView()
    }
}
