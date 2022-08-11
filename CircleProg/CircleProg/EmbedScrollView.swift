//
//  EmbedScrollView.swift
//  CircleProg
//
//  Created by Don Mag on 8/11/22.
//

import SwiftUI

class PassScrollView: UIScrollView {
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		print(#function, point)
		//return super.hitTest(point, with: event)
		return self.subviews.first
	}
}
struct UIScrollViewWrapper<Content: View>: UIViewRepresentable {
	
	var width: CGFloat
	var height: CGFloat
	
	@ViewBuilder var content: () -> Content
	
	func makeUIView(context: Context) -> UIScrollView {
		let scrollView = UIScrollView()
		//let scrollView = PassScrollView()

		scrollView.clipsToBounds = false
		scrollView.delegate = context.coordinator
		scrollView.isScrollEnabled = true
		scrollView.showsVerticalScrollIndicator = false
		
		let child = UIHostingController(rootView: content())
		child.view.backgroundColor = .yellow // .clear
		
		context.coordinator.hostingController = child
		scrollView.addSubview(child.view)
		
		let newSize = child.view.sizeThatFits(CGSize(width: width, height: height))
		child.view.frame = CGRect(origin: .zero, size: newSize)
		
		scrollView.contentSize = newSize
		
		return scrollView
	}
	
	func updateUIView(_ scrollView: UIScrollView, context: Context) {
		context.coordinator.hostingController?.rootView = content()
		
		if let child = context.coordinator.hostingController {
			let newSize = child.view.sizeThatFits(CGSize(width: width, height: height))
			child.view.frame = CGRect(origin: .zero, size: newSize)
			
			scrollView.contentSize = newSize
		}
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	class Coordinator: NSObject, UIScrollViewDelegate {
		var parent: UIScrollViewWrapper
		var hostingController: UIHostingController<Content>!
		
		init(_ parent: UIScrollViewWrapper) {
			self.parent = parent
		}
	}
}

struct EmbedScrollView: View {
/*
	var body: some View {
		GeometryReader { geometry in
			VStack(spacing: 0) {
				RoundedRectangle(cornerRadius: 15)
					.fill(.cyan)
					.overlay(
						Text("SwiftUI View")
							.foregroundColor(.white)
					)
					.frame(height: 75)
					.onTapGesture {
						print("SwiftUI")
					}
				
				UIScrollViewWrapper(width: geometry.size.width, height: geometry.size.height - 75) {
					RoundedRectangle(cornerRadius: 15)
						.fill(.mint)
						.frame(height: geometry.size.height * 2)
						.onTapGesture {
							print("UIScrollView")
						}
						//.allowsHitTesting(true)
					
				}
				.border(.red, width: 2)
				
			}
			
		}
	}
*/
/*
	var body: some View {
		GeometryReader { geometry in
			ZStack(alignment: .top) {
				RoundedRectangle(cornerRadius: 15)
					.fill(.cyan)
					.overlay(
						Text("SwiftUI View")
							.foregroundColor(.white)
					)
					.frame(height: 75)
					.onTapGesture {
						print("SwiftUI")
					}
				
				UIScrollViewWrapper(width: geometry.size.width, height: geometry.size.height) {
					RoundedRectangle(cornerRadius: 15)
						.fill(.mint)
						.frame(height: geometry.size.height * 2)
						.offset(y: 75)
						.onTapGesture {
							print("UIScrollView")
						}
				}
				.border(.red, width: 2)
			}
			
		}
	}
*/
	
	var body: some View {
		GeometryReader { geometry in
			VStack(spacing: 0) {
				UIScrollViewWrapper(width: geometry.size.width, height: geometry.size.height - 75) {
					RoundedRectangle(cornerRadius: 15)
						.fill(.red)
						.overlay(
							Text("SwiftUI View")
								.foregroundColor(.white)
						)
						.frame(height: 75)
						.onTapGesture {
							print("SwiftUI")
						}
					
					RoundedRectangle(cornerRadius: 15)
						.fill(.blue)
						.frame(height: geometry.size.height * 2)
						.onTapGesture {
							print("UIScrollView")
						}
				
				}
				.border(.green, width: 2)
				
			}
			
		}
	}

	
}

struct EmbedScrollView_Previews: PreviewProvider {
    static var previews: some View {
        EmbedScrollView()
    }
}
