//
//  StackIssueView.swift
//  CircleProg
//
//  Created by Don Mag on 3/24/23.
//

import SwiftUI

struct MyShapeOrig : Shape {
	func path(in rect: CGRect) -> Path {
		
		return Path { path in
			path.move(to: .zero)
			path.addLine(to: CGPoint(x: UIScreen.main.bounds.width / 2 - 48, y: 0))
			
			path.addArc(center: CGPoint(x: UIScreen.main.bounds.width / 2 - 48, y: 10),
						radius: 10,
						startAngle: .degrees(-90),
						endAngle: .degrees(0),
						clockwise: false)
			
			path.addCurve(to: CGPoint(x: UIScreen.main.bounds.width / 2 + 48, y: 0),
						  control1: CGPoint(x: UIScreen.main.bounds.width / 2 - 80, y: 105),
						  control2: CGPoint(x: UIScreen.main.bounds.width / 2 + 80, y: 105))
			
			path.addArc(center: CGPoint(x: UIScreen.main.bounds.width / 2 + 48, y: 10),
						radius: 10,
						startAngle: .degrees(-90),
						endAngle: .degrees(-180),
						clockwise: true)
			
			path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
			path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 100))
			path.addLine(to: CGPoint(x: 0, y: 100))
			path.addLine(to: .zero)
			path.closeSubpath()
		}
	}
}

/*
class TestButton: UIButton {
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupButton()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupButton()
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupButton() {
		setTitleColor(.white, for: .normal)
		backgroundColor = .red
		titleLabel?.font = .boldSystemFont(ofSize: 25)
		layer.cornerRadius = 10
	}
}

struct TestSwiftUIView: View {
	@State var text: [String] = ["This is a line of text"]
	var body: some View {
		VStack {
			ForEach(text, id: \.self) { text in
				Text(text)
			}
			Button {
				text.append("New line")
			} label: {
				Text("Add line")
			}
			.padding()
			.background(Color.red)
		}
		.foregroundColor(.white)
		.background(Color.green)
	}
}
*/
@available(iOS 16.0, *)
struct StackIssueView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
			.onAppear {
				let renderer = ImageRenderer(content: Text("Hello, world!"))
				
				if let uiImage = renderer.uiImage {
					print(uiImage.size)
					if let d = uiImage.jpegData(compressionQuality: 0.9) {
						print("image as jpeg data successful")
					}
					// use the rendered image somehow
				}
			}
    }
}

@available(iOS 16.0, *)
struct JpegView: View {
	
	var textView: some View {
		Text("Hello, SwiftUI")
			.padding()
			.background(.red)
			.foregroundColor(.white)
			.clipShape(Capsule())
	}
	
	var body: some View {
		VStack {
			textView
				.onTapGesture {
					let renderer = ImageRenderer(content: textView)
					
					if let uiImage = renderer.uiImage {
						print("created UIImage - size:", uiImage.size)
						if let d = uiImage.jpegData(compressionQuality: 0.9) {
							print("image as jpeg data successful")
							// use the data somehow
						}
					}
				}
		}
	}
	
}

@available(iOS 16.0, *)
struct StackIssueView_Previews: PreviewProvider {
    static var previews: some View {
        StackIssueView()
    }
}
