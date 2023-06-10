//
//  Walkthrough.swift
//  CircleProg
//
//  Created by Don Mag on 12/19/22.
//

import SwiftUI

struct WalkthroughView: View {
	var walkthroughs: [Walkthrough] = Walkthrough.allCases
	@State var currentIndex = 0
	@State var bounceAnimation: Bool = true
	
	var body: some View {
		
		ZStack {
			VStack(alignment: .leading) {
				popTipView(with: walkthroughs[currentIndex % walkthroughs.count])
			}
			VStack {
				Spacer()
				Button("Tap here") {
					currentIndex += 1
					withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: true)) {
						self.bounceAnimation.toggle()
					}
				}
			}
		}
	}
	
	private func popTipView(with currentWalkthrough: Walkthrough) -> some View {
		PopTipSwiftUI(walkThrough: currentWalkthrough)
			.offset(x: currentWalkthrough.position.x,
					y: bounceAnimation ? currentWalkthrough.position.y : currentWalkthrough.position.y - 8)
	}
}


enum Walkthrough: CaseIterable {
	case first
	case second
	case third
	case fourth
	case fifth
	
	var position: CGPoint {
		switch self {
		case .first:
			return CGPoint(x: 0, y: -200)
		case .second:
			return CGPoint(x: 0, y: 100)
		case .third:
			return CGPoint(x: -20, y: 200)
		case .fourth:
			return CGPoint(x: -20, y: 50)
		case .fifth:
			return CGPoint(x: -20, y: 250)
			
		}
	}
	var alignment: PopTipAlignment {
		switch self {
		case .first:
			return .topLeft
		case .second:
			return .topRight
		case .third:
			return .bottomCenter
		case .fourth:
			return .topLeft
		case .fifth:
			return .topCenter
		}
	}
	
	var message: String {
		return "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
	}
	
	var leftImage: String? {
		switch self {
		case .third:
			return "eye.slash"
		default:
			return nil
		}
	}
}

enum PopTipAlignment {
	case topLeft
	case topRight
	case topCenter
	case bottomCenter
	case bottomLeft
	case bottomRight
	
	var horizontalAlignment: SwiftUI.HorizontalAlignment {
		switch self {
		case .topLeft, .bottomLeft:
			return .leading
		case .topCenter, .bottomCenter:
			return .center
		default:
			return .trailing
		}
	}
	
	var offSet: CGFloat {
		switch self {
		case .topLeft, .bottomLeft:
			return 24
		case .topCenter, .bottomCenter:
			return 0
		default:
			return -16
		}
	}
}


struct PopTipSwiftUI: View {
	
	// MARK: Public APIs
	var walkThrough: Walkthrough = .first
	
	// MARK: Private properties
	private var alignment: PopTipAlignment {
		walkThrough.alignment
	}
	
	// MARK: Initialiser
	var body: some View {
		VStack(alignment: walkThrough.alignment.horizontalAlignment, spacing: -Constant.spacing) {
			if alignment == .topLeft || alignment == .topCenter || alignment == .topRight {
				triangularPointer
			}
			textContainerView
			if alignment == .bottomLeft || alignment == .bottomCenter || alignment == .bottomRight {
				triangularPointer
					.rotationEffect(.radians(.pi))
				
			}
		}
		.frame(maxWidth: Constant.maxWidth)
		.background(Color.clear)
	}
	
	// MARK: UI setup
	private var textContainerView: some View {
		HStack(alignment: .center) {
			horizontalSpacerView
			VStack {
				verticalSpacerView
				textView
				verticalSpacerView
			}
			horizontalSpacerView
		}
		.background(Color.black.opacity(Constant.bgOpacity))
		.cornerRadius(Constant.cornerRadius)
	}
	
	private var textView: some View {
		HStack(spacing: Constant.textViewSpacing) {
			leftImage
			Text(walkThrough.message)
				.font(.subheadline)
				.multilineTextAlignment(.leading)
				.foregroundColor(Color.white)
			rightChevronContainerView
		}
	}
	
	// MARK: UI components
	@ViewBuilder
	private var leftImage: some View {
		if let leftImage = walkThrough.leftImage {
			VStack {
				Image(systemName: leftImage)
					.resizable()
					.frame(width: Constant.leftImageWidth, height: Constant.leftImageHeight)
			}
			.frame(width: Constant.leftImageWidth, height: Constant.leftImageHeight)
		} else {
			EmptyView()
		}
		
	}
	
	private var rightChevronContainerView: some View {
		VStack(alignment: .center) {
			Image(systemName: "chevron.right")
				.resizable()
				.frame(width: Constant.chevronWidth, height: Constant.chevronHeight)
				.foregroundColor(Color.green)
		}
		.frame(width: Constant.chevronContainerWidth, height: Constant.chevronContainerHeight)
		.background(Color.black.opacity(Constant.chevronContainerOpacity))
		.cornerRadius(Constant.chevronContainerRadius)
	}
	
	private var triangularPointer: some View {
		VStack {
			Triangle()
				.fill(Color.black.opacity(Constant.bgOpacity))
		}
		.frame(width: Constant.triangleSize, height: Constant.triangleSize)
		.offset(x: alignment.offSet)
	}
	
	private var horizontalSpacerView: some View {
		Spacer()
			.frame(width: Constant.spacerWidth)
	}
	
	private var verticalSpacerView: some View {
		Spacer()
			.frame(height: Constant.spacerHeight)
	}
	
	// MARK: Constants
	private enum Constant {
		static let spacerHeight: CGFloat = 20
		static let spacerWidth: CGFloat = 20
		static let cornerRadius: CGFloat = 19
		static let bgOpacity: CGFloat = 0.80
		static let maxWidth: CGFloat = 300
		static let spacing: CGFloat = 0.5
		static let triangleSize: CGFloat = 8
		static let chevronWidth: CGFloat = 4
		static let chevronHeight: CGFloat = 8
		static let chevronContainerHeight: CGFloat = 28
		static let chevronContainerWidth: CGFloat = 40
		static let chevronContainerOpacity: CGFloat = 0.85
		static let chevronContainerRadius: CGFloat = 19
		static let leftImageWidth: CGFloat = 40
		static let leftImageHeight: CGFloat = 28
		static let textViewSpacing: CGFloat = 8
	}
}

struct Triangle: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()
		path.move(to: CGPoint(x: rect.midX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
		return path
	}
}




struct WalkthroughView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
