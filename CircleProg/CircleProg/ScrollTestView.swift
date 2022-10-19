//
//  ScrollTestView.swift
//  CircleProg
//
//  Created by Don Mag on 2/17/22.
//

import SwiftUI

struct xScrollTestView: View {
	
	@State var numRows: Int = 30
	
	var body: some View {
		
		GeometryReader { geometry in
			
			ScrollView {
				
				// "outer" VStack
				//	minimum Height is the scroll view height
				VStack(alignment: .center, spacing: 0) {
					if numRows > 0 {
						// "blue" VStack with variable number of "rows"
						//	remove a row on each tap
						VStack(alignment: .center, spacing: 20) {
							Text("Each tap in blue frame removes a row.")
							ForEach((1...numRows), id: \.self) {
								Text("Hello \($0)")
							}
						}
						.frame(maxWidth: .infinity)
//						.background(Color.blue)
						.background(
							GeometryReader { proxy in
								Color.blue.onAppear { print(proxy.size.height) }
							}
						)
						.onTapGesture {
							print("g", geometry.size.height)
							if numRows > 0 {
								numRows -= 1
							}
						}
					}

					Text("Hello World\nEach tap in gray frame adds a row above.")
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.multilineTextAlignment(.center)
						.background(Color.gray)
						.padding(24)
						.onTapGesture {
							numRows += 1
						}

				}
				.frame(minHeight: geometry.size.height)
				
			}
			
		}
		
	}

}

struct ScrollTestView: View {
	var body: some View {
		ScrollView([.horizontal, .vertical]){
			ScrollViewReader { proxy in
				VStack(spacing: 100){
					ForEach(1..<50){ i in
						let x: CGFloat = i % 2 == 0 ? 0.0 : 400.0
						Button(action: {
							proxy.scrollTo(i, anchor: .center)
						}, label: {
							Text("Number \(i)")
						})
						.background(Color.green)
						.padding(.trailing, x)
						//.padding(.leading, Double(i)*20)
							.id(i)
					}
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				.background(Color.yellow)
			}
		}
	}
	
}

struct ScrollTestView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollTestView()
    }
}
