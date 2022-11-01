//
//  BotToTopView.swift
//  CircleProg
//
//  Created by Don Mag on 10/18/22.
//

import SwiftUI

struct BotToTopView: View {
	let designImage = Image("swiftRed")
	var body: some View {
		
		VStack {
			Image("blankBag")
				.resizable()
				.scaledToFill()
				.aspectRatio(3/(false ? 3 : 4), contentMode: .fit)
				.frame(width: UIScreen.main.bounds.width - 40.0,alignment: .center)
				.cornerRadius(16)
				.shadow(color: Color.black, radius: 8, x: 0, y: 0)
				.overlay(
					designImage
						.resizable()
						.offset(x: 30 + 70, y: 76 + 70)
						.frame(width: 240, height: 240)
				)
				.clipped()
				.overlay(
					Image("BagWithCutout")
						.resizable()
						.scaledToFill()
						.cornerRadius(16)
				)
			
			//			HStack{
			//				TowerView().padding()
			//			}
		}.padding()

		
//		VStack {
//			Image("blankBag")
//				.resizable()
//				.scaledToFill()
//				.aspectRatio(3/(false ? 3 : 4), contentMode: .fit)
//				.frame(width: UIScreen.main.bounds.width - 40.0,alignment: .center)
//				.cornerRadius(16)
//				.shadow(color: Color.black, radius: 8, x: 0, y: 0)
//
//				.overlay(
//					designImage
//						.resizable()
//						.offset(x: 30, y: 76)
//						.frame(width: 180, height: 180)
//				)
//
//
////			HStack{
////				TowerView().padding()
////			}
//		}.padding()
	}
}

struct BotToTopView_Previews: PreviewProvider {
    static var previews: some View {
        BotToTopView()
    }
}

let colors = [Color.red, Color.green, Color.blue, Color.yellow]

struct DiskView: View {
	
	let id:Int!
	var body: some View {
		ZStack{
			colors[id % colors.count]
			Text("\(id)").foregroundColor(.white)
		}
	}
}

struct TowerView: View {
	
	@State var items: [Int] = [0]

	func hanoiTapped(){
		items.insert(items.count, at: 0)
	}
	private func exportCSV (withManagedObjects arrManagedObject:[String]) {
		
	}
	var body: some View {
		
		ZStack{
			Button (action: { exportCSV(withManagedObjects: ["A", "B"]) } ) {
				Text("Export Data")
					.padding()
			}

			Image("logo")
				.resizable()
				.frame(width: 160, height: 60)
				.gesture(TapGesture().onEnded({ _ in
					hanoiTapped()
				}))
			VStack() {
				Spacer()
				ForEach(0..<items.count, id: \.self) { index in
					DiskView(id:items[index]).frame(width:50, height:10).padding(.vertical,5)
				}
			}
		}

	}

}

struct SleepModel {
	var todaysDate: Date = Date()
	var hoursSlept: Int = 0
}
private func exportCSV (withSleepModeObjects arrObjects:[SleepModel]) {
	var csvString = "Date, HoursSlept\n"
	arrObjects.forEach { obj in
		let d = String(describing: obj.todaysDate)
		let h = String(describing: obj.hoursSlept)
		let csvLine = "\(d), \(h)\n"
		csvString.append(csvLine)
	}
	let fileManager = FileManager.default
	let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
	let path = directory.appendingPathComponent("People").appendingPathExtension("csv")
	if(!fileManager.fileExists(atPath:path.path)){
		fileManager.createFile(atPath: path.path, contents: nil, attributes: nil)
	}
	do {
		try csvString.write(to: path, atomically: true, encoding: .utf8)
		print(path)
	} catch let error {
		print("Error creating CSV export file \(error.localizedDescription)")
	}
}

