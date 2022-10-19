//
//  BotToTopView.swift
//  CircleProg
//
//  Created by Don Mag on 10/18/22.
//

import SwiftUI

struct BotToTopView: View {
	var body: some View {
		VStack {
			Text("Hello, world!")
			HStack{
				TowerView().padding()
			}
		}.padding()
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

