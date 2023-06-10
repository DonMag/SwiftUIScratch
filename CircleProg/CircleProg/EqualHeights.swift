//
//  EqualHeights.swift
//  CircleProg
//
//  Created by Don Mag on 12/28/22.
//

import SwiftUI

class UIViewTestClass: UIView {
	override func draw(_ rect: CGRect) {
		"Test".draw(at: CGPoint(x: rect.midX, y: rect.midY))
		let context = UIGraphicsGetCurrentContext()
		context?.addRect(rect)
		context?.stroke(rect)
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		setNeedsDisplay()
	}
}
struct TestUIView: UIViewRepresentable {
	typealias UIViewType = UIView
	func makeUIView(context: Context) -> UIView {
		let result = UIViewTestClass()
		result.backgroundColor = UIColor(.white)
		return result
	}
	
	func updateUIView(_ uiView: UIView, context: Context) {
	}
}

struct EqualHeights: View {

	//@State var orientation = UIDevice.current.orientation
	
	let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
		.makeConnectable()
		.autoconnect()
	
	var body: some View {
		TestUIView()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		//            .aspectRatio(contentMode: .fit)
			.padding()
//			.onReceive(orientationChanged) { _ in
//				TestUIView.updateUIView(self)
//			}
	}
}


struct EqualHeights_Previews: PreviewProvider {
    static var previews: some View {
        EqualHeights()
    }
}

