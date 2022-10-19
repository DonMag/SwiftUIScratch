//
//  StackSpace.swift
//  CircleProg
//
//  Created by Don Mag on 9/14/22.
//

import SwiftUI

struct StackSpace: View {
	let myRed: Color = .init(red: 1.0, green: 0.6, blue: 0.6)
	let myGreen: Color = .init(red: 0.5, green: 1.0, blue: 0.5)
	let myBlue: Color = .init(red: 0.2, green: 0.9, blue: 1.0)
	
	var body: some View {
		HStack {
			VStack {
				Text("Row 1")
					.background(myRed)
				Text("Row 2")
					.background(myGreen)
				Text("Row 3 - ∞ -")
					.frame(maxHeight: .infinity)
					.background(myBlue)
			}
			.frame(maxWidth: 120, maxHeight: .infinity)
			.background(.yellow)

			VStack {
				Text("Row 1")
					.background(myRed)
				Text("Row 2 - ∞ -")
					.frame(maxHeight: .infinity)
					.background(myGreen)
				Text("Row 3")
					.background(myBlue)
			}
			.frame(maxWidth: 120, maxHeight: .infinity)
			.background(.yellow)

			VStack {
				Text("Row 1 - ∞ -")
					.frame(maxHeight: .infinity)
					.background(myRed)
				Text("Row 2")
					.background(myGreen)
				Text("Row 3")
					.background(myBlue)
			}
			.frame(maxWidth: 120, maxHeight: .infinity)
			.background(.yellow)
			
			VStack {
				Text("Row 1 - ∞ -")
					.frame(maxHeight: .infinity)
					.background(myRed)
				Text("Row 2 - ∞ -")
					.frame(maxHeight: .infinity)
					.background(myGreen)
				Text("Row 3 - ∞ -")
					.frame(maxHeight: .infinity)
					.background(myBlue)
			}
			.frame(maxWidth: 120, maxHeight: .infinity)
			.background(.yellow)
			
			VStack {
				Text("Row 1")
					.background(myRed)
				Text("Row 2")
					.background(myGreen)
				Text("Row 3 - ∞ -")
					.frame(maxHeight: .infinity)
					.background(myBlue)
				Text("Row 4")
					.background(myGreen)
				Text("Row 5")
					.background(myRed)
			}
			.frame(maxWidth: 120, maxHeight: .infinity)
			.background(.yellow)
			
		}
		.frame(maxHeight: 300)
		.background(.cyan)
	}
}

struct StackSpace_Previews: PreviewProvider {
    static var previews: some View {
        StackSpace()
    }
}
