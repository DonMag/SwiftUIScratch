//
//  AnimScroll.swift
//  CircleProg
//
//  Created by Don Mag on 8/17/22.
//

import SwiftUI

struct AnimScroll: View {
	@State private var animating = false
	
	var body: some View {
		VStack {
			ScrollView(showsIndicators: false) {
				
				ScrollViewReader { value in
					Button("Jump to #8") {
						value.scrollTo(12, anchor: .bottom)
					}
					.padding()
					
					ForEach(0..<51, id: \.self) { index in
						Text("\(index)")
							.font(.system(size: 60))
							.opacity(animating ? 1 : 0)
							.animation(.easeIn(duration: 0.5).delay(Double(index)), value: animating)
					}
				}
			}
		}
		.onAppear {
			animating.toggle()
			callFunc()
		}
	}
	
	func callFunc() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			print("-----> callFunc")
			callFunc()
		}
	}
}

struct AnimScroll_Previews: PreviewProvider {
	static var previews: some View {
		AnimScroll()
	}
}
