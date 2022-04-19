//
//  CaptureView.swift
//  CircleProg
//
//  Created by Don Mag on 4/19/22.
//

import SwiftUI

struct CaptureView: View {
	
	var testCard: some View {
		VStack {
			Spacer()
			GeometryReader { geometry in
				Image("sampleBackground")
					.resizable()
					.frame(width: geometry.size.width, height: geometry.size.height)
					.cornerRadius(20.0)
			}
			Spacer()
		}
		.frame(width: 320, height: 240)
		.padding(.horizontal)
		.overlay(
			VStack {
				VStack {
					HStack {
						HStack(alignment: .center) {
							Image("logo")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(height: 40)
								.padding(.leading)
							VStack(alignment: .leading, spacing: 3) {
								Text("AppName")
									.foregroundColor(.white)
									.font(.headline)
									.fontWeight(.bold)
								
								Text(Date(), style: .date)
									.foregroundColor(.white)
									.font(.footnote)
							}
						}
						Spacer()
					}
					.padding([.leading, .top])
					Spacer()
				}
				.frame(height: 220)
			}
		)
	}
	
    var body: some View {
		VStack {
			Spacer()
			Text("Tap red Button to capture view")
			Spacer()
			testCard
			Spacer()
			Button("Capture testCard View") {
				let img = testCard.snapshot(atSize: CGSize(width: 320.0, height: 240.0))
				saveImage(img)
			}
			.padding()
			.foregroundColor(.white)
			.background(Color.red)
			.cornerRadius(40)
			Spacer()
		}
		.background(Color(red: 1.0, green: 1.0, blue: 0.0))
    }
	
	func saveImage(_ img: UIImage) {
		var s: String = "Results:\n\n"
		
		let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
		let fName: String = "testCard.png"
		let url = documents.appendingPathComponent(fName)
		if let data = img.pngData() {
			do {
				try data.write(to: url)
			} catch {
				s += "Unable to Write Image Data to Disk"
				print(s)
				return
			}
		} else {
			s += "Could not get png data"
			print(s)
			return
		}
		s += "Logical Size: \(img.size)\n"
		s += "Scale: \(img.scale)\n"
		s += "Actual Size: \(CGSize(width: img.size.width * img.scale, height: img.size.height * img.scale))\n"
		s += "File \"\(fName)\" saved to Documents folder\n"
		print(s)

		// print the path to documents in debug console
		//	so we can copy/paste into Finder to get to the files
		print(documents.path)

	}
}

extension View {
	// if view HAS a valid .intrinsicContentSize
	func snapshot() -> UIImage {
		let controller = UIHostingController(rootView: self)
		let view = controller.view
		
		let targetSize = controller.view.intrinsicContentSize
		view?.bounds = CGRect(origin: .zero, size: targetSize)
		view?.backgroundColor = .clear
		
		let renderer = UIGraphicsImageRenderer(size: targetSize)
		
		return renderer.image { _ in
			view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
		}
	}
	// specify size to save
	func snapshot(atSize targetSize: CGSize) -> UIImage {
		let controller = UIHostingController(rootView: self, ignoreSafeArea: true)
		let view = controller.view
		
		view?.bounds = CGRect(origin: .zero, size: targetSize)
		view?.backgroundColor = .clear
		
		let renderer = UIGraphicsImageRenderer(size: targetSize)
		
		return renderer.image { _ in
			view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
		}
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

struct CaptureView_Previews: PreviewProvider {
    static var previews: some View {
        CaptureView()
    }
}
