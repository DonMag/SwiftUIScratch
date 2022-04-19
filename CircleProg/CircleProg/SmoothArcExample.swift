//
//  SmoothArcExample.swift
//  CircleProg
//
//  Created by Don Mag on 10/29/21.
//

import SwiftUI

struct SmoothArcExample: View {
	var body: some View {
		let minX = UIScreen.main.bounds.minX
		let midX = UIScreen.main.bounds.midX
		let maxX = UIScreen.main.bounds.maxX
		
		let w: CGFloat = 50
		let w2: CGFloat = w * 1.0
		let r: CGFloat = 40
		
		let yf: CGFloat = 0
		
		let b1 = CGPoint(x: minX, y: w)
		let b2 = CGPoint(x: midX - w2 + yf, y: w)
		let b3 = CGPoint(x: midX + w2 - yf, y: w)
		let b4 = CGPoint(x: maxX, y: w)
		
		let peak = CGPoint(x: midX, y: w * 2.0 + yf + 40)
		

		ZStack {
//			Path { path in
//				path.move(to: b2)
//				path.addLine(to: peak)
//				path.addLine(to: b3)
//			}
//			//.stroke(Color.green, lineWidth: 3)
//			.stroke(Color.clear, lineWidth: 3)


			Path { path in

				
				let t: CGFloat = 50
				let x1: CGFloat = midX - r * 2.0
				let x2: CGFloat = midX + r * 2.0
				let c1 = CGPoint(x: x1, y: t + r)
				let c2 = CGPoint(x: midX, y: t + r - 25 + 10)
				let c3 = CGPoint(x: x2, y: t + r)

				//path.move(to: CGPoint(x: x1, y: t))
				
				let degOffset:Double = 20
				
				let d1: Angle = .degrees(-degOffset)
				let d2: Angle = .degrees(180 - degOffset)
				let d3: Angle = .degrees(degOffset)
				let d4: Angle = .degrees(180 + degOffset)

				path.addArc(center: c1, radius: r, startAngle: .degrees(-90), endAngle: d1, clockwise: false)
				path.addArc(center: c2, radius: r, startAngle: d2, endAngle: d3, clockwise: true)
				path.addArc(center: c3, radius: r, startAngle: d4, endAngle: .degrees(270), clockwise: false)

//				path.addArc(tangent1End: b2, tangent2End: peak, radius: r - 20)
//				path.addArc(tangent1End: peak, tangent2End: b3, radius: r - 0)
//				path.addArc(tangent1End: b3, tangent2End: b4, radius: r - 20)
				
//				path.addLine(to: b4)
				
			}
			.stroke(Color.green, lineWidth: 3)
			
		Path { path in

			path.move(to: b1)
			
			path.addArc(tangent1End: b2, tangent2End: peak, radius: r - 20)
			path.addArc(tangent1End: peak, tangent2End: b3, radius: r - 0)
			path.addArc(tangent1End: b3, tangent2End: b4, radius: r - 20)

			path.addLine(to: b4)
			
		}
		.stroke()
			
		}
	}
}

struct SmoothArcExample_Previews: PreviewProvider {
    static var previews: some View {
        SmoothArcExample()
    }
}

/*
Path { path in
let minX = UIScreen.main.bounds.minX
let midX = UIScreen.main.bounds.midX
let maxX = UIScreen.main.bounds.maxX
let base1 = CGPoint(x: midX - 100, y: .zero)
let base2 = CGPoint(x: midX + 100, y: .zero)
let ctrl1 = CGPoint(x: midX - 50, y: .zero)
let ctrl2 = CGPoint(x: midX + 50, y: .zero)
let curv1 = CGPoint(x: midX - 100, y: 0)
let curv2 = CGPoint(x: midX + 50, y: 100)

//path.move(to: base1)

//			path.addArc(tangent1End: curv1, tangent2End: ctrl1, radius: 50)
//path.addArc(tangent1End: curv1, tangent2End: peak, radius: 50)

let t1 = CGPoint(x: midX - 50, y: 0)
let t2 = CGPoint(x: midX - 50, y: 50)

let t3 = CGPoint(x: midX, y: 50)
let t4 = CGPoint(x: midX + 50, y: 50)
let t5 = CGPoint(x: midX + 100, y: 0)
let t6 = CGPoint(x: midX + 200, y: 0)

let v1 = CGPoint(x: midX - 100, y: 25)

let v2 = CGPoint(x: midX, y: 50)


let v3 = CGPoint(x: midX + 100, y: 25)
let v4 = CGPoint(x: midX - 0, y: 0)

let c1 = CGPoint(x: midX - 0, y: 0)
let c2 = CGPoint(x: midX - 25, y: 50)

let c3 = CGPoint(x: midX + 75, y: 50)
let c4 = CGPoint(x: midX + 25, y: 0)

let w: CGFloat = 50
let w2: CGFloat = w * 1.0
let r: CGFloat = 50

let yf: CGFloat = 0

path.move(to: b1)

path.addArc(tangent1End: b2, tangent2End: peak, radius: r)
path.addArc(tangent1End: peak, tangent2End: b3, radius: r)
path.addArc(tangent1End: b3, tangent2End: b4, radius: r)

path.addLine(to: b4)

//			path.addCurve(to: peak, control1: c1, control2: c2)
//			path.addCurve(to: b3, control1: c3, control2: c4)

//			path.addQuadCurve(to: v1, control: c1)
//			path.addQuadCurve(to: v2, control: c2)

//path.addLine(to: b4)

//			path.addArc(tangent1End: t1, tangent2End: t2, radius: 50)
//
//			path.addArc(tangent1End: t2, tangent2End: t3, radius: 50)
//			//path.addArc(tangent1End: t3, tangent2End: t4, radius: 50)
//			path.addArc(tangent1End: t4, tangent2End: t5, radius: 50)
//			path.addArc(tangent1End: t5, tangent2End: t6, radius: 50)

//			path.addQuadCurve(to: curv1, control: ctrl1)
//			path.addQuadCurve(to: curv2, control: peak)
//			//path.addArc(center: peak, radius: 10, startAngle: .degrees(180), endAngle: .degrees(0), clockwise: true)
//			path.addQuadCurve(to: base2, control: ctrl2)
}
.stroke()

*/
