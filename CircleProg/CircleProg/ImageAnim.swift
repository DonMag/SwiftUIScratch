//
//  ImageAnim.swift
//  CircleProg
//
//  Created by Don Mag on 7/9/22.
//

import SwiftUI


struct ImageAnim_Previews: PreviewProvider {
    static var previews: some View {
        ImageAnim()
    }
}

struct ImageAnim: View {
	
	@State var match = false
	@Namespace var namespace
	
	@State var snapshot:UIImage?
	
	var body: some View {
		
		Image("island")
			.resizable()
			//.scaledToFill()
			.frame(width: 300, height: 300)
			.clipped()

		ZStack {
			
			if !match {
				AView { img in
					snapshot = img
					withAnimation {
						match.toggle()
					}
				}
				.frame(width: 300, height: 300)
				.clipped()
				.matchedGeometryEffect(id: "1", in: namespace, properties: .frame)
			}
			
			
			if match && snapshot != nil {
				Color.clear.ignoresSafeArea().overlay(
					BView(image: snapshot!)
						.matchedGeometryEffect(id: "1", in: namespace, properties: .frame)
						.frame(width: 600, height: 600)
						.transition(.scale)
						.onTapGesture {
							withAnimation {
								match.toggle()
							}
						}
				)
			}
		}
		// .statusBar(hidden: true) // <-- THIS REMOVES THE RED GAP IN BView, but I want to keep the status bar. I want BView to work regadless.
	}
	
}


struct AView: View {
	
	var didTap:(_ img:UIImage)->()
	
	var body: some View {
		
		GeometryReader { geo in
			ZStack(alignment: .center) {
				Image("island")
					.resizable()
					.scaledToFill()
			}
			//            .frame(width: geo.size.width, height: geo.size.height)
			.border(.purple)
			.onTapGesture {
				didTap(snapshot(size: geo.size))
			}
			
		}
		.border(.yellow)
	}
	
}



struct BView: View {
	
	@State var image:UIImage
	
	var body: some View {
		ZStack {
			
			Color.red.ignoresSafeArea()
			
			Image(uiImage: image)
				.resizable()
				.aspectRatio(contentMode: .fill)
		}
	}
}



extension View {
	
	func snapshot(origin: CGPoint = .zero, size: CGSize = .zero) -> UIImage {
		let controller = UIHostingController(rootView: self)
		controller.disableSafeArea()
		let view = controller.view
		
		let targetSize = size == .zero ? controller.view.intrinsicContentSize : size
		view?.backgroundColor = .clear
		view?.bounds = CGRect(origin: origin, size: targetSize)
		
		let renderer = UIGraphicsImageRenderer(size: targetSize)
		
		return renderer.image { _ in
			view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
		}
	}
	
}

