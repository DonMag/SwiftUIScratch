//
//  WithUIKitButton.swift
//  CircleProg
//
//  Created by Don Mag on 10/13/22.
//

import SwiftUI

struct WithUIKitButton: View {
	var body: some View {
		NavigationView {
			VStack {
				Bridge()
					.frame(height: 100)
				Button("SwiftUI Button") {
					debugPrint("SwiftUI Button Clicked")
				}
			}
			.onTapGesture {
				debugPrint("User tapped")
			}
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
}

struct WithUIKitButton_Previews: PreviewProvider {
    static var previews: some View {
        WithUIKitButton()
    }
}

struct Bridge: UIViewRepresentable {
	func makeUIView(context: Context) -> some UIView {
		//return FromXIBView()
		return UIKitButtonView()
	}
	func makeCoordinator() -> Coordinator {
		return Coordinator()
	}
	func updateUIView(_ uiView: UIViewType, context: Context) { }
	
	class Coordinator: NSObject {}
}

class UIKitButtonView: UIView {
	@IBOutlet var contentView: UIView!
	@IBOutlet var uikitButton: UIButton!
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	private func setup() {
		Bundle.main.loadNibNamed("UIKitButtonView", owner: self, options: nil)
		addSubview(contentView)
		contentView.frame = self.bounds
		contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		contentView.frame = self.bounds
	}
	@IBAction func buttonAction(_ sender: Any) {
		debugPrint("UIKit button clicked")
	}
//	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//		print(point, bounds)
//		return uikitButton
//		//return super.hitTest(point, with: event)
//	}
}

class FromXIBView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	private func setup() {
		if let t = Bundle.main.loadNibNamed("FromXIBView", owner: self, options: nil) {
			if let contentView = t[0] as? UIView {
				addSubview(contentView)
				contentView.frame = self.bounds
				contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
				contentView.frame = self.bounds
				if let btn = contentView.subviews.first as? UIButton {
//					let t = UITapGestureRecognizer(target: self, action: #selector(buttonAction(_:)))
//					btn.addGestureRecognizer(t)
					btn.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
				}
			}
		}
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		print(#function)
	}
	@IBAction func buttonAction(_ sender: Any) {
		debugPrint("UIKit button clicked")
	}
}

