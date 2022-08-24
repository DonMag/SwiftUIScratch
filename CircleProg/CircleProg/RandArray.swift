//
//  RandArray.swift
//  CircleProg
//
//  Created by Don Mag on 8/19/22.
//

import SwiftUI

struct RandArray: View {
	@State private var numbers = ["0", "1", "2", "3", "4", "5"].shuffled()
	@State private var currentNumber = ""
	
	@State private var appearedNumber = [String]()
	
	var body: some View {
		NavigationView {
			VStack {
				NavigationLink {
					SecondView(appearedNumber: $appearedNumber)
				} label: {
					Text("Change view")
				}
				.padding()
				
				Text(currentNumber)
					.font(.largeTitle)
					.bold()
				
				Button {
					changeNumber()
				} label: {
					Text("Change person")
						.font(.largeTitle)
						.bold()
				}
				.padding()
			}
		}
		// add this
		.onAppear() {
			changeNumber()
		}
	}
	func changeNumber() {
		if numbers.count > 0 {
			currentNumber = numbers.removeFirst()
			appearedNumber.append(currentNumber)
		} else {
			currentNumber = "out of numbers"
		}
	}
}

struct RandArray_Previews: PreviewProvider {
    static var previews: some View {
        RandArray()
    }
}

struct SecondView: View {
	@Binding var appearedNumber: [String]
	
	var body: some View {
		VStack {
			ForEach(0..<appearedNumber.count, id: \.self) { index in
				Text(appearedNumber[index])
					.font(.largeTitle)
					.bold()
			}
		}
	}
}

