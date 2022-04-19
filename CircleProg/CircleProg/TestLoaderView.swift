//
//  TestLoaderView.swift
//  CircleProg
//
//  Created by Don Mag on 1/26/22.
//

import SwiftUI

struct TestLoaderView: View {
	@State private var value: CGFloat = 50
	
	var body: some View {
		LoaderView(activeValue: value, totalValue: 100)
			.padding()
		
		Button("add") { value += 10 }
		.padding()
	}
}

struct LoaderView: View {
	let activeValue: CGFloat
	let totalValue: CGFloat
	let activeColor: Color
	let totalColor: Color
	
	init(activeValue: CGFloat, totalValue: CGFloat, activeColor: Color = Color.green, totalColor: Color = Color.secondary) {

		print("init")

		if activeValue >= totalValue { self.activeValue = totalValue }
		else if activeValue < 0 { self.activeValue = 0 }
		else { self.activeValue = activeValue }
		
		self.totalValue = totalValue
		self.activeColor = activeColor
		self.totalColor = totalColor
		
	}
	
	@State private var startAnimation: Bool = .init()
	private let heightOfCapsule: CGFloat = 5.0
	
	var body: some View {
		let linearGradient = LinearGradient(colors: [Color.yellow.opacity(0.1), Color.yellow], startPoint: .leading, endPoint: .trailing)
		
		return GeometryReader { proxy in
			
			totalColor
				.overlay(
					Capsule()
						.fill(activeColor)
						.frame(width: (activeValue / totalValue) * proxy.size.width)
						//.frame(width: (name / totalValue) * proxy.size.width)
						.overlay(
							Capsule()
								.fill(linearGradient)
								.frame(width: 100)
								.offset(x: startAnimation ? 100 : -100),
							alignment: startAnimation ? Alignment.trailing : Alignment.leading)
						.clipShape(Capsule()),
					alignment: Alignment.leading)
				.clipShape(Capsule())
		}
		.frame(height: heightOfCapsule)
		.onAppear(perform: {
			startAnimation.toggle()
		})
		.animation(Animation.default, value: activeValue)
		.animation(Animation.linear(duration: 3.0).repeatForever(autoreverses: false), value: startAnimation)
	}
}

struct TestLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        TestLoaderView()
    }
}
