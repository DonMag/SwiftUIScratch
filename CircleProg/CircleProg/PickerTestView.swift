//
//  PickerTestView.swift
//  CircleProg
//
//  Created by Don Mag on 3/13/21.
//

import SwiftUI

struct PickerTestView: View {
/*
	enum Unit: String, CaseIterable {
		case meters = "m"
		case kilometers = "km"
		case feet = "ft"
		case yards = "yd"
		case miles = "mi"
		
	}
	
	@State private var unitSelection: Unit = .meters
	@State private var measureToConvert = ""
	
	@State private var conversionFromMeasure = "km"
	
	@State private var convertedToMeasure = "m"
	
	let measure = ["m", "km", "ft", "yd", "mi"]
	
	
	func convertInMillimeters(input: String, number: String) -> Double {
		
		var value: Double = 0
		
		if let realNumber = Double(number) {
			
			switch input {
			
			case "m":
				
				let conversion = (Double(realNumber) * 1_000)
				
				value = conversion
				
			case "km":
				let conversion = (Double(realNumber) * 1_000_000)
				value = conversion
				
			case "ft":
				let conversion = (Double(realNumber) * 304.8)
				value = conversion
				
			case "yd":
				let conversion = (Double(realNumber) * 914.4)
				return conversion
				
			case "mi":
				let conversion = (Double(realNumber) * 1_609_344)
				value = conversion
			default:
				
				let conversion = -2.0
				
				value = conversion
			}
			
		}
		
		print("value in millimeters is \(value)")
		return value
		
		
	}
	
	
	
	func convertToNewMeasure(input: String, number: Double) -> Double {
		
		var value: Double = 0
		
		switch input {
		
		case "m" :
			
			let conversion = (number / 1_000)
			
			value = conversion
			
		case "km":
			let conversion = (number / 1_000_000)
			value = conversion
			
		case "ft":
			let conversion = (number / 304.8)
			value = conversion
			
		case "yd":
			let conversion = (number / 914.4)
			return conversion
			
		case "mi":
			let conversion = (number / 1_609_344)
			value = conversion
			
		default:
			
			let conversion = -1.0
			
			value = conversion
		}
		
		
		print("value converted is \(value)")
		return value
		
	}
	
	var inMillimeters : Double {
		return convertInMillimeters(input: conversionFromMeasure, number: measureToConvert)
	}
	
	var result: Double {
		
		return convertToNewMeasure(input: convertedToMeasure, number: inMillimeters)
	}
	
	
	var body: some View {
		
		NavigationView{
			
			Form{
				
				
				Section(header: Text("Value to convert:")){
					TextField("Enter a measure", text: $measureToConvert).keyboardType(.decimalPad)
					
				}
				
				
				
				Section(header: Text("Select input measure")){
					Picker("From", selection: $unitSelection) {
						ForEach(Unit.allCases, id: \.self){ unit in
							Text(unit.rawValue)
							
							
						}
						
					}.pickerStyle(SegmentedPickerStyle())
				}
				
				
				Section(header: Text("Select output measure")){
					Picker("To", selection: $convertedToMeasure) {
						ForEach(0 ..< measure.count) {
							Text("\(self.measure[$0])")
							
						}
						
					}.pickerStyle(SegmentedPickerStyle())        }
				
				
				
				
				Section(header: Text("Converted value")){
					Text("\(result, specifier: "%.2f")")
				}
			}
			.navigationBarTitle("Measure Converter")
		}
	}
*/


	@State private var measureToConvert = ""
	
	@State private var conversionFromMeasure = "km"
	
	@State private var convertedToMeasure = "m"
	
	let measure = ["m", "km", "ft", "yd", "mi"]
	
	func convertInMillimeters(input: String, number: String) -> Double {
		
		var value: Double = 0
		
		if let realNumber = Double(number) {
			
			switch input {
			
			case "m":
				
				let conversion = (Double(realNumber) * 1_000)
				
				value = conversion
				
			case "km":
				let conversion = (Double(realNumber) * 1_000_000)
				value = conversion
				
			case "ft":
				let conversion = (Double(realNumber) * 304.8)
				value = conversion
				
			case "yd":
				let conversion = (Double(realNumber) * 914.4)
				return conversion
				
			case "mi":
				let conversion = (Double(realNumber) * 1_609_344)
				value = conversion
			default:
				
				let conversion = -2.0
				
				value = conversion
			}
			
		}
		
		print("value in millimeters is \(value)")
		return value
		
		
	}
	
	
	
	func convertToNewMeasure(input: String, number: Double) -> Double {
		
		var value: Double = 0
		
		switch input {
		
		case "m" :
			
			let conversion = (number / 1_000)
			
			value = conversion
			
		case "km":
			let conversion = (number / 1_000_000)
			value = conversion
			
		case "ft":
			let conversion = (number / 304.8)
			value = conversion
			
		case "yd":
			let conversion = (number / 914.4)
			return conversion
			
		case "mi":
			let conversion = (number / 1_609_344)
			value = conversion
			
		default:
			
			let conversion = -1.0
			
			value = conversion
		}
		
		
		print("value converted is \(value)")
		return value
		
	}
	
	var inMillimeters : Double {
		return convertInMillimeters(input: conversionFromMeasure, number: measureToConvert)
	}
	
	var result: Double {
		
		return convertToNewMeasure(input: convertedToMeasure, number: inMillimeters)
	}
	
	
	var body: some View {

		NavigationView{
			
			Form{
				
				Section(header: Text("Value to convert:")){
					TextField("Enter a measure", text: $measureToConvert).keyboardType(.decimalPad)
				}
				
				Section(header: Text("Select input measure")){
					Picker("From", selection: $conversionFromMeasure) {
						ForEach(measure, id: \.self) {
							Text($0)
						}
					}
					.pickerStyle(SegmentedPickerStyle())
				}
				
				
				Section(header: Text("Select output measure")){
					Picker("To", selection: $convertedToMeasure) {
						ForEach(measure, id: \.self) {
							Text($0)
						}
					}.pickerStyle(SegmentedPickerStyle())
				}
				
				Section(header: Text("Converted value")){
					Text("\(result, specifier: "%.2f")")
				}
				
			}
			.navigationBarTitle("Measure Converter")
		}
		
	}

}

struct PickerTestView_Previews: PreviewProvider {
	static var previews: some View {
		PickerTestView()
	}
}

