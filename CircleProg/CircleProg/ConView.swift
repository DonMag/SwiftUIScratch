//
//  ConView.swift
//  CircleProg
//
//  Created by Don Mag on 1/31/23.
//

import SwiftUI

final class wasTestButton: UIButton {
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	
	func setup() {
		translatesAutoresizingMaskIntoConstraints = false
		setTitle("Hello", for: .normal)
		
		// if this class is used in a UIKit auto-layout environment
		// setting these constraints here will define the size of the button
		//	intrinsicContentSize will have no effect
		heightAnchor.constraint(equalToConstant: 200).isActive = true
		widthAnchor.constraint(equalToConstant: 300).isActive = true
	}
	
	// add this override
	override var intrinsicContentSize: CGSize {
		// if this class is used as you implemented it in SwiftUI
		//	this will define the size of the button
		return .init(width: 300.0, height: 200.0)
		
	}
}

final class nvmTestButton: UIButton {
	var myWidth: CGFloat = 300.0 {
		didSet {
			wConstraint.constant = myWidth
		}
	}
	var myHeight: CGFloat = 200.0 {
		didSet {
			hConstraint.constant = myHeight
		}
	}
	private var wConstraint: NSLayoutConstraint!
	private var hConstraint: NSLayoutConstraint!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	
	func setup() {
		translatesAutoresizingMaskIntoConstraints = false
		setTitle("Hello", for: .normal)
		
		// initialize width and height constraints to default values
		wConstraint = widthAnchor.constraint(equalToConstant: myWidth)
		hConstraint = heightAnchor.constraint(equalToConstant: myHeight)
		
		// let's use a less-than required Priority so we can override them if desired
		wConstraint.priority = .required - 1
		hConstraint.priority = .required - 1
		
		// activate them
		wConstraint.isActive = true
		hConstraint.isActive = true
		
	}
	
	// add this override
	override var intrinsicContentSize: CGSize {
		// if this class is used as you implemented it in SwiftUI
		//	this will define the size of the button
		return .init(width: myWidth, height: myHeight)
	}
	
}

final class TestButton: UIButton {
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	
	func setup() {
		translatesAutoresizingMaskIntoConstraints = false
		setTitle("Hello", for: .normal)
		
		heightAnchor.constraint(equalToConstant: 200).isActive = true
		widthAnchor.constraint(equalToConstant: 300).isActive = true
	}
	
	override var intrinsicContentSize: CGSize {
		return .init(width: 300.0, height: 200.0)
		
	}
}

struct TestView: View {
	var body: some View {
		VStack(alignment: .center, spacing: 20.0) {
			Text("SwiftUI")
			TestButtonWrapper()
				.background(Color.red)
		}
	}
}

struct TestButtonWrapper: UIViewRepresentable {
	func makeUIView(context: Context) -> TestButton {
		let view = TestButton()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		view.setContentHuggingPriority(.defaultHigh, for: .vertical)
		return view
	}
	
	func updateUIView(_ uiView: TestButton, context: Context) {
	}
}


//struct TestButtonWrapper: UIViewRepresentable {
//	func makeUIView(context: Context) -> TestButton {
//		let view = TestButton()
//		view.translatesAutoresizingMaskIntoConstraints = false
//		view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//		view.setContentHuggingPriority(.defaultHigh, for: .vertical)
//		return view
//	}
//
//	func updateUIView(_ uiView: TestButton, context: Context) {
//	}
//}

struct TestView_Previews: PreviewProvider {
	static var previews: some View {
		TestView()
	}
}


/*
final class TestButton: UIButton {
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	
	func setup() {
		translatesAutoresizingMaskIntoConstraints = false
		setTitle("Hello", for: .normal)
		// these are ignored:
//		heightAnchor.constraint(equalToConstant: 200).isActive = true
//		widthAnchor.constraint(equalToConstant: 300).isActive = true
	}
}

struct TestButtonWrapper: UIViewRepresentable {
	func makeUIView(context: Context) -> UIView {
		let cv = UIView()
		let view = TestButton()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .yellow
		cv.addSubview(view)
//		view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//		view.setContentHuggingPriority(.defaultHigh, for: .vertical)

		view.heightAnchor.constraint(equalToConstant: 200).isActive = true
		view.widthAnchor.constraint(equalToConstant: 300).isActive = true
		if let sv = view.superview {
			view.topAnchor.constraint(equalTo: sv.topAnchor).isActive = true
			view.leadingAnchor.constraint(equalTo: sv.leadingAnchor).isActive = true
			view.trailingAnchor.constraint(equalTo: sv.trailingAnchor).isActive = true
			view.bottomAnchor.constraint(equalTo: sv.bottomAnchor).isActive = true
		}
		return cv
	}
	
	func updateUIView(_ uiView: UIView, context: Context) {
	}
}
*/
