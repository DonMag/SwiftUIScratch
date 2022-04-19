//
//  ProfileContainerView.swift
//  CircleProg
//
//  Created by Don Mag on 4/16/22.
//

import SwiftUI

struct ProfileContainerView: View {
	var subView: ProfileActionButtonView = ProfileActionButtonView()

	var backgroundImage: UIImage = UIImage()
	@State var proxy: GeometryProxy?
	
	var testCard: some View {
		VStack {
			Spacer()
			GeometryReader { geometry in
				Image("sampleBackground")
					.resizable()
					.frame(width: geometry.size.width, height: geometry.size.height)
					.cornerRadius(20.0)
					.onAppear {
						proxy = geometry
					}
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
				.frame(height: 240)
			}
		)

	}
/*
	var shareCard: some View {
		VStack {
			Spacer()
			GeometryReader { geometry in
				if backgroundImage != UIImage() {
					Image(uiImage: backgroundImage)
						.resizable()
						.scaledToFill()
						.frame(width: geometry.size.width, height: geometry.size.height)
						.clipped() //needed to add clipped otherwise the picture would go outside of the frame.  From https://sarunw.com/posts/how-to-resize-swiftui-image-and-keep-aspect-ratio/
						.cornerRadius(10.0)
						.overlay(
							Color.black
								.cornerRadius(10.0)
								.opacity(0.45) //keep at 0.45?
						)
				} else {
					Image("sampleBackground")
						.resizable()
					//.scaledToFill()
						.frame(width: geometry.size.width, height: geometry.size.height)
						.cornerRadius(10.0)
						.onAppear {
							proxy = geometry
						}
				}
			}
			Spacer()
		}
		.frame(height: 375)
		.padding(.horizontal)
		.overlay(
			TabView {
			//TabView(selection: $selectedTabIndex) {
				//Omitted - these are views that are overlayed over the background or image and don't impact the size of the snapshot

			}
				.frame(height: 430)
				.padding(.horizontal)
//				.tabViewStyle(.page(indexDisplayMode: isTakingSnapShot ? .never : .always))
				.overlay(
					VStack {
						switch shareType {
						case 1: // .TodaySummary:
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
							.frame(height: 375)
						case 2: // .Workout:
							EmptyView() //Pass empty view here because we use a different header for workout share
						default:
							EmptyView()
						}
					}
				)
		)
		
	}
*/
    var body: some View {
		VStack {
			Spacer()
			Text("Top")
//			Spacer()
//			subView
			Spacer()
			testCard
				//.frame(width: 320, height: 240, alignment: .center)
			Spacer()
			Button("Capture Center View") {
				let img = testCard.snapshot(atSize: CGSize(width: 320.0, height: 240.0))
				print("tap")
			}
			
			Spacer()
		}
    }
}


//extension View {
//	func asImage() -> UIImage {
//		let renderer = UIGraphicsImageRenderer(size: CGSize(width: 300, height: 200))
//		return renderer.image { context in
//			layer.render(in: context.cgContext)
//		}
//	}
//}
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

extension View {
//	func takeScreenshot(origin: CGPoint, size: CGSize) -> UIImage? {
//
//		// Get the main window.
//		guard let window = UIApplication.shared.windows.first else {
//			print("View.takeScreenshot: No main window found")
//			return nil
//		}
//
//		// Create an image of the entire window. Note how we're using `window.bounds` for this
//		// to capture the entire window.
//		UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, 0.0)
//		let renderer = UIGraphicsImageRenderer(bounds: window.bounds, format: UIGraphicsImageRendererFormat())
//		let image = renderer.image { (context) in
//			window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
//		}
//		UIGraphicsEndImageContext()
//
//		/*
//		 At this point we have a screenshot of the entire window.
//		 Now we're going to crop it to just include the part of the screen
//		 we want.
//		 */
//
//		// Scale is the pixel density of the screen. E.g. 3.0 on iPhone 12 Pro which has a 3x display.
//		// This will be used in the UIImage extension below.
//		let scale = UIScreen.main.scale
//		let rect = CGRect(x: origin.x, y: origin.y, width: size.width, height: size.height)
//		let croppedImage = image.cropped(boundingBox: rect, scale: scale)
//
//
//		return croppedImage
//	}
}

struct ProfileContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileContainerView()
    }
}
