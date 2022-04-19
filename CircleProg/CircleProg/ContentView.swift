//
//  ContentView.swift
//  CircleProg
//
//  Created by Don Mag on 1/29/21.
//

import SwiftUI

struct ContentView: View {
	@State var progress: CGFloat = 0.0
	
	@State var currentPlaceData : String?
	
	func getTimeline () {
		
		var entries: [String] = ["A", "B"]
		
		
				func random() -> String? {
					
					let allPlaces = entries
					let randomIndex = Int.random(in: 0..<allPlaces.count)
					
					return allPlaces[randomIndex]
				}
				
				let cPlaceData = random() //<-------- Found nil in cPlaceData
				self.currentPlaceData = cPlaceData
			
		
	}
	
	var progressAnimation: Animation {
		Animation
			.linear
			.speed(0.5)
			.delay(0.2)
	}

	var body: some View {
		let gradient = LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .leading, endPoint: .trailing)
		let lineWidth: CGFloat = 25

		ZStack {
			Circle()
				.stroke(Color(.systemFill).opacity(0.5), style: StrokeStyle(lineWidth: lineWidth))
				.frame(height: 125)
			
			Circle()
				.trim(from: 1.0 - self.progress, to: 1)
				.stroke(gradient, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
				.animation(self.progressAnimation, value: 1.0 - self.progress)
				.rotationEffect(Angle(degrees: 90))
				.rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
				.frame(height: 125)

		}
		.gesture(
			TapGesture()
				.onEnded { _ in
					self.progress += 0.1
					self.getTimeline()
				}
		)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
struct PageDetail: View {
	
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	@Binding var bookData: [String]
	@State var count = 0
	
	var progress: CGFloat{
		let page = value
		let total = Int(book.total) ?? 1
		
		let answer = CGFloat(page)/CGFloat(total)
		return answer
	}
	var value: Int{
		let page = Int(book.page) ?? 1
		let cnt = count
		let calc = page + cnt
		return calc
	}
	
	var book: Book{
		
		var body: some View {
			ZStack{
				LinearGradient(...)
				
				VStack {
					VStack(spacing: -25){
						ProgressBar(page: value,total: book.total ,progress: progress)
							.frame(width: 250, height: 300)
							.padding(.horizontal, 20)
						HStack {
							Button(action: {
								self.count -= 1
							}, label: {
								Image(systemName: "minus.circle")
							})
							
							
							Button(action: {
								self.count += 1
							}, label: {
								Image(systemName: "plus.circle")
							})
							
						}
					}
					
				}
			}
		}
		struct ProgressBar: View {
			var page: Int
			var total: String
			var progress: CGFloat
			var body: some View {
				let gradient = LinearGradient(...)
				ZStack {
					Circle()
						.stroke(lineWidth: 25)
						.opacity(0.3)
						.foregroundColor(Color.secondary)
					
					Circle()
						.trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
						.stroke(gradient ,style: StrokeStyle(lineWidth: 25.0, lineCap: .round, lineJoin: .round))
						.rotationEffect(Angle(degrees: 270.0))
						.animation(.linear)
				}
			}
		}
		
		struct PageDetail_Previews: PreviewProvider {
			@State static var previewed = testData
			static var previews: some View {
				PageDetail(bookData: $previewed, book: previewed[0])
			}
		}
	}
}

*/
