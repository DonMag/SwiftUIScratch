//
//  TextTransition.swift
//  CircleProg
//
//  Created by Don Mag on 11/1/22.
//

import SwiftUI

struct TextTransition: View {
	@State private var secondsValue = "21"
	@State private var seconds: Int = 21

	var body: some View {
		VStack (spacing: 50) {
			ZStack {
				Text(secondsValue)
					.font(.title)
					.fontWeight(.semibold)
					.monospacedDigit()
					.foregroundColor(Color.white)
					.frame(width: 60, height: 40)
					.transition(AnyTransition.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
					.id("Seconds" + secondsValue)
			}
			.background(Color.red)
			.frame(width: 60, height: 40)
			.clipped()
			
			Button("Next") {
				seconds += 1
				withAnimation (.easeInOut(duration: 0.5)) {
					self.secondsValue = "\(seconds)"
				}
			}
		}
	}

}

struct TextTransition_Previews: PreviewProvider {
    static var previews: some View {
        TextTransition()
    }
}

class TimeManager: ObservableObject {
	@Published var date = Date()
	@Published var oldDate = Date()
	
	func timeString(timeFormat: String, date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = timeFormat
		
		let time = formatter.string(from: date)
		return time
	}
	
	// update time
	var updateTimer: Timer {
		withAnimation(.spring()){
			Timer.scheduledTimer(withTimeInterval: 1, repeats: true,
								 block: {_ in
				
				self.oldDate = self.date
				self.date = Date()
				
			})
		}
	}
}

struct BoxesView: View {
	
	@EnvironmentObject var timeManager: TimeManager
	
	var body: some View {
		
		HStack(spacing: 30) {
			
			let timeElements = splitUpTime()
			
			ForEach(timeElements, id: \.self) { timeElement in
				SingleBoxElement(text: timeElement)
			}
			
			
		}.ignoresSafeArea()
	}
	
	func splitUpTime() -> Array<String> {
		
		let splitDate = timeManager.timeString(timeFormat: "HH:mm:ss", date: timeManager.date).components(separatedBy: ":")
		
		return splitDate
	}
}

struct SingleBoxElement: View {
	
	let text: String
	
	var body: some View {
		
		ZStack {
			
			RoundedRectangle(cornerRadius: 12)
				.foregroundColor(.pink)
			
			Text(text)
				.foregroundColor(.white)
				.font(.title)
				.fontWeight(.semibold)
				.monospacedDigit()
			
			
		}.frame(width: 90, height: 90)
	}
}
