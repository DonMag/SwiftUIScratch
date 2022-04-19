//
//  ViewController.swift
//  SBwithSUI
//
//  Created by Don Mag on 4/2/22.
//

import UIKit
import SwiftUI

class oViewController: UIViewController {

	var cv: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let contentView = UIHostingController(rootView: ContentView())

		addChild(contentView)
		
		guard let v = contentView.view else {
			fatalError("Could not load SwiftUI View!!!!")
		}

		view.addSubview(contentView.view)
		contentView.didMove(toParent: self)
		
		contentView.view.translatesAutoresizingMaskIntoConstraints = false
		
		let g = view.safeAreaLayoutGuide
		
		
		NSLayoutConstraint.activate([
			v.topAnchor.constraint(equalTo: g.topAnchor, constant: 40.0),
			v.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 60.0),
			v.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -60.0),
			v.heightAnchor.constraint(equalToConstant: 200.0),
			//v.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -40.0),
		])
		
		v.backgroundColor = .yellow
		
		cv = v
		
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let img = cv.asImage()
		print(img.size)
		print()
	}

}

class ViewController: UIViewController {

	let imgView = UIImageView()
	
	override func viewDidLoad() {
		super.viewDidLoad()

		imgView.contentMode = .center
		
		imgView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(imgView)

		let g = view.safeAreaLayoutGuide
		
		NSLayoutConstraint.activate([
			// let's put the imageView 40-pts from Top
			imgView.topAnchor.constraint(equalTo: g.topAnchor, constant: 40.0),
			// centered horizontally
			imgView.centerXAnchor.constraint(equalTo: g.centerXAnchor),
			// width: 240
			imgView.widthAnchor.constraint(equalToConstant: 240.0),
			// height: 200
			imgView.heightAnchor.constraint(equalToConstant: 200.0),
		])

		// show the image view background so we
		//	can see its frame
		imgView.backgroundColor = .systemGreen

	}

	// we will generate the image in viewDidLayoutSubview()
	//	but that can be (and usually is) called more than once
	//	so we'll use this to make sure we only generate the image once
	var firstTime: Bool = true
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		// we only want this to run once
		if firstTime {
			firstTime = false
			if let img = imageFromContentView() {
				imgView.image = img
			}
		}
	
	}

	func imageFromContentView() -> UIImage? {
		
		let swiftUIView = UIHostingController(rootView: ContentView(), ignoreSafeArea: true)
		
		// add as chlld controller
		addChild(swiftUIView)
		
		// make sure we can get its view (safely unwrap its view)
		guard let v = swiftUIView.view else {
			swiftUIView.willMove(toParent: nil)
			swiftUIView.removeFromParent()
			return nil
		}
		
		view.addSubview(v)
		swiftUIView.didMove(toParent: self)
		
		// size the view to its content
		v.sizeToFit()
		
		// for this explicit example, the "ring" extends vertically
		//	outside the bounds of the zStack
		//	so we'll add 10-pts height
		v.frame.size.height += 10.0
		
		// force it to layout its subviews
		v.setNeedsLayout()
		v.layoutIfNeeded()
		
		// if we want to see the background
		v.backgroundColor = .systemYellow
		
		// get it as a UIImage
		let img = v.asImage()
		
		// we're done with it, so get rid of it
		v.removeFromSuperview()
		swiftUIView.willMove(toParent: nil)
		swiftUIView.removeFromParent()
		
		return img
		
	}
	
	func imageFromContentViewA() -> UIImage? {
		
		let swiftUIView = UIHostingController(rootView: ContentView())
		
		// add as chlld controller
		addChild(swiftUIView)
		
		// make sure we can get its view (safely unwrap its view)
		guard let v = swiftUIView.view else {
			swiftUIView.willMove(toParent: nil)
			swiftUIView.removeFromParent()
			return nil
		}
		
		view.addSubview(v)
		swiftUIView.didMove(toParent: self)
		
		// size the view to its content
		v.sizeToFit()
		
		// force it to layout its subviews
		v.setNeedsLayout()
		v.layoutIfNeeded()
		
		// if we want to see the background
		v.backgroundColor = .systemYellow
		
		// get it as a UIImage
		let img = v.asImage()
		
		// we're done with it, so get rid of it
		v.removeFromSuperview()
		swiftUIView.willMove(toParent: nil)
		swiftUIView.removeFromParent()
		
		return img
		
	}
	
	func imageFromContentViewB() -> UIImage? {
		
		let swiftUIView = UIHostingController(rootView: ContentView())
		
		// add as chlld controller
		addChild(swiftUIView)
		
		// make sure we can get its view (safely unwrap its view)
		guard let v = swiftUIView.view else {
			swiftUIView.willMove(toParent: nil)
			swiftUIView.removeFromParent()
			return nil
		}
		
		view.addSubview(v)
		swiftUIView.didMove(toParent: self)

		// Add This Line
		// add same bottom safe area inset as top
		swiftUIView.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: v.safeAreaInsets.top, right: 0)
		
		// size the view to its content
		v.sizeToFit()
		
		// force it to layout its subviews
		v.setNeedsLayout()
		v.layoutIfNeeded()
		
		// if we want to see the background
		v.backgroundColor = .systemYellow
		
		// get it as a UIImage
		let img = v.asImage()
		
		// we're done with it, so get rid of it
		v.removeFromSuperview()
		swiftUIView.willMove(toParent: nil)
		swiftUIView.removeFromParent()
		
		return img
		
	}
}

// extension to remove safe area from UIHostingController
//	source: https://stackoverflow.com/a/70339424/6257435
extension UIHostingController {
	convenience public init(rootView: Content, ignoreSafeArea: Bool) {
		self.init(rootView: rootView)
		
		if ignoreSafeArea {
			disableSafeArea()
		}
	}
	
	func disableSafeArea() {
		guard let viewClass = object_getClass(view) else { return }
		
		let viewSubclassName = String(cString: class_getName(viewClass)).appending("_IgnoreSafeArea")
		if let viewSubclass = NSClassFromString(viewSubclassName) {
			object_setClass(view, viewSubclass)
		}
		else {
			guard let viewClassNameUtf8 = (viewSubclassName as NSString).utf8String else { return }
			guard let viewSubclass = objc_allocateClassPair(viewClass, viewClassNameUtf8, 0) else { return }
			
			if let method = class_getInstanceMethod(UIView.self, #selector(getter: UIView.safeAreaInsets)) {
				let safeAreaInsets: @convention(block) (AnyObject) -> UIEdgeInsets = { _ in
					return .zero
				}
				class_addMethod(viewSubclass, #selector(getter: UIView.safeAreaInsets), imp_implementationWithBlock(safeAreaInsets), method_getTypeEncoding(method))
			}
			
			objc_registerClassPair(viewSubclass)
			object_setClass(view, viewSubclass)
		}
	}
}

extension UIView {
	func asImage() -> UIImage {
		let renderer = UIGraphicsImageRenderer(size: frame.size)
		return renderer.image { context in
			layer.render(in: context.cgContext)
		}
	}
}
public extension UIImage {
	func round(_ radius: CGFloat) -> UIImage {
		let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		let renderer = UIGraphicsImageRenderer(size: rect.size)
		let result = renderer.image { c in
			let rounded = UIBezierPath(roundedRect: rect, cornerRadius: radius)
			rounded.addClip()
			if let cgImage = self.cgImage {
				UIImage(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation).draw(in: rect)
			}
		}
		return result
	}
	func circle() -> UIImage {
		let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		let renderer = UIGraphicsImageRenderer(size: rect.size)
		let result = renderer.image { c in
			let isPortrait = size.height > size.width
			let isLandscape = size.width > size.height
			let breadth = min(size.width, size.height)
			let breadthSize = CGSize(width: breadth, height: breadth)
			let breadthRect = CGRect(origin: .zero, size: breadthSize)
			let origin = CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0,
								 y: isPortrait  ? floor((size.height - size.width) / 2) : 0)
			let circle = UIBezierPath(ovalIn: breadthRect)
			circle.addClip()
			if let cgImage = self.cgImage?.cropping(to: CGRect(origin: origin, size: breadthSize)) {
				UIImage(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation).draw(in: rect)
			}
		}
		return result
	}
}
/*
 func imageFromSUIView(_ suiView: UIHostingController<ContentView>) -> UIImage? {
 
 // add as chlld controller
 addChild(suiView)
 
 // make sure we can get its view (safely unwrap its view)
 guard let v = suiView.view else {
 suiView.willMove(toParent: nil)
 suiView.removeFromParent()
 return nil
 }
 
 view.addSubview(v)
 suiView.didMove(toParent: self)
 
 // use its defined size
 v.sizeToFit()
 v.frame.size.height += 10.0
 
 // force it to layout its subviews
 v.setNeedsLayout()
 v.layoutIfNeeded()
 
 // if we want to see the background
 v.backgroundColor = .systemYellow
 
 // get it as a UIImage
 let img = v.asImage()
 
 // we're done with it, so get rid of it
 v.removeFromSuperview()
 suiView.willMove(toParent: nil)
 suiView.removeFromParent()
 
 return img
 
 }
 

 */

class CategoryCollectionViewCell: UICollectionViewCell {
	
}
