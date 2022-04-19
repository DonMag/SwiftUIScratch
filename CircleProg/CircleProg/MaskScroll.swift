//
//  MaskScroll.swift
//  CircleProg
//
//  Created by Don Mag on 2/11/22.
//

import SwiftUI

struct MaskScroll: View {

	@State var numRows: Int = 1

	var body: some View {
		VStack {
			Text("Wrapped UIScrollView Test").padding()
			Divider()
			WrappedScrollView()
			Spacer()
		}
	}

}

struct WrappedScrollView: UIViewRepresentable {
	typealias UIViewType = MyScrollView
	func makeUIView(context: Context) -> MyScrollView {
		let v = MyScrollView()
		return v
	}
	func updateUIView(_ uiView: MyScrollView, context: Context) {}
}

class MyScrollView: UIScrollView {
	init() {
		super.init(frame: .zero)
		translatesAutoresizingMaskIntoConstraints = false
		let content = MyContentView()
		self.addSubview(content)
		
		// This is how you define the scrollable area with UIScrollView
		content.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		content.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		content.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
		content.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
		
		// I only want to scroll horizontally
		self.heightAnchor.constraint(equalTo: content.heightAnchor).isActive = true

		// But I have to use this hack to get it to show up. (320 is width of my screen)
		// self.widthAnchor.constraint(equalToConstant: 320).isActive = true
	}
	required init?(coder: NSCoder) { fatalError() }

	override func didMoveToSuperview() {
		// unwrap optional superview
		guard let sv = superview else {
			print("this will never happen, because we are INSIDE didMoveToSuperview()")
			return
		}
		// constrain self leading/trailing to superview
		self.leadingAnchor.constraint(equalTo: sv.leadingAnchor).isActive = true
		self.trailingAnchor.constraint(equalTo: sv.trailingAnchor).isActive = true
	}
}

// Just two blue and green squares, so you can see scrolling.
class MyContentView: UIView {
	
	init() {
		super.init(frame:.zero)
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	override var intrinsicContentSize: CGSize {
		return .init(width: 500, height: 200)
	}
	
	override func draw(_ rect: CGRect) {
		guard let c = UIGraphicsGetCurrentContext() else { return }
		print("draw \(bounds)")
		var r1 = bounds
		r1.size.width = 250
		var r2 = r1
		r2.origin.x = 250
		c.setFillColor(UIColor.blue.cgColor)
		c.fill(r1)
		c.setFillColor(UIColor.green.cgColor)
		c.fill(r2)
	}
}

struct MaskScroll_Previews: PreviewProvider {
    static var previews: some View {
        MaskScroll()
    }
}
