//
//  MultiDateView.swift
//  CircleProg
//
//  Created by Don Mag on 12/17/22.
//

import SwiftUI

@available(iOS 16.0, *)
struct MultiDateView: View {
	@Environment(\.calendar) private var calendar
	
	@State private var selectedDates: Set<DateComponents> = []
	
	@State private var onChangeCounter = 0
	
	var body: some View {
		VStack {
			MultiDatePicker("Select dates", selection: $selectedDates)
				.frame(height: UIScreen.main.bounds.width)
				.onChange(of: selectedDates) { _ in
					print("onChange")
					selectedDates.forEach { d in
						print(d)
					}
					print()
					self.onChangeCounter += 1
				}
			
			Button("Select today") {
				let todayDatecomponents = calendar.dateComponents(in: calendar.timeZone, from: Date.now)
				selectedDates.insert(todayDatecomponents)
			}
			.foregroundColor(.white)
			.frame(minWidth: 150)
			.padding()
			.background(Color.accentColor)
			.cornerRadius(20)
			
			Button("Select today the right way") {
				let todayDatecomponents = calendar.dateComponents([.calendar, .era, .year, .month, .day], from: Date.now)
				selectedDates.insert(todayDatecomponents)
			}
			.foregroundColor(.white)
			.frame(minWidth: 150)
			.padding()
			.background(Color.green)
			.cornerRadius(20)
			
			HStack {
				Text("onChangeCounter")
				Spacer()
				Text(String(onChangeCounter))
			}
			.padding()
			
			Button("Print Date.now in debug console") {
				print("debug")
				print("debug:", Date.now)
				print()
			}
			.foregroundColor(.white)
			.frame(minWidth: 150)
			.padding()
			.background(Color.red)
			.cornerRadius(20)
			
			Spacer()
		}
	}
}

@available(iOS 16.0, *)
struct MultiDateView_Previews: PreviewProvider {
    static var previews: some View {
        MultiDateView()
    }
}
