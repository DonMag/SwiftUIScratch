//
//  TotalView.swift
//  CircleProg
//
//  Created by Don Mag on 3/6/21.
//

import SwiftUI

struct Pixel: Identifiable, Hashable {
	var id: Int
	var isColored: Bool
}


class Model: ObservableObject {
	
	@Published var pixels: [Pixel]
	
	// so we can interrupt the filling loop
	@Published var keepRunning: Bool = false
	
	init(totalPixels: Int) {
		pixels = (1...totalPixels).map{ Pixel(id: $0, isColored: false)}
	}
	
	func pixelsRange(num:Int, clusterDimension:Int) -> [Pixel]{
		return Array(pixels[(num-1)*clusterDimension..<clusterDimension*num])
	}
	
	func startFillingAllAnimated() {
		// if "start" button tapped,
		//	"un-color" all the pixels
		for idx in self.pixels.indices {
			self.pixels[idx].isColored = false
		}
		// start filling them
		resumeFilling()
	}
	
	func resumeFilling() {
		// if ALL pixels are already "colored" don't do anything (just return)
		guard let i = pixels.firstIndex(where: {$0.isColored == false}) else { return }
		// set the running flag
		keepRunning = true
		DispatchQueue.global().async {
			// start at the first non-colored pixel
			for idx in i..<self.pixels.count {
				// insert a slight delay
				//	based on quick testing...
				//	0.0020 will take about 3 seconds to fill them all
				//	0.0010 will take about 1.5 seconds to fill them all
				//	0.0002 will take about 0.3 seconds to fill them all
				//	anything shorter pretty much fills them all instantly
				//	so, you probably want somewhere between
				Thread.sleep(forTimeInterval: 0.0010)
				DispatchQueue.main.async {
					self.pixels[idx].isColored = true
				}
				// if keepRunning was set to false, break out of the loop
				if !self.keepRunning {
					break
				}
			}
		}
	}

	// call this if we want to Stop
	//	before the grid has been completely filled
	func stopFilling() {
		self.keepRunning = false
	}
	
}

struct TotalView: View {
	
	static var totalPixels = 1280
	
	@StateObject var model = Model(totalPixels: totalPixels)
	
	var clusterDimension = 16
	
	static let bigSpacing:CGFloat = 2
	
	let bigColumns = [
		GridItem(.flexible(), spacing: bigSpacing),
		GridItem(.flexible(), spacing: bigSpacing),
		GridItem(.flexible(), spacing: bigSpacing),
		GridItem(.flexible(), spacing: bigSpacing),
		GridItem(.flexible(), spacing: bigSpacing),
		GridItem(.flexible(), spacing: bigSpacing),
		GridItem(.flexible(), spacing: bigSpacing),
		
		GridItem(.flexible(), spacing: bigSpacing)
	]
	
	@State var numToBeColored: Int = 8
	
	var body: some View {
		
		VStack {
			
			Button("start") {
				model.startFillingAllAnimated()
			}
			Button("stop") {
				model.stopFilling()
			}
			Button("resume") {
				model.resumeFilling()
			}
			ScrollView {
				LazyVGrid(columns: bigColumns, alignment: .center, spacing: 2){
					ForEach(0..<TotalView.totalPixels/clusterDimension, id: \.self) { num in
						ClusterView(pixels: $model.pixels, clusterNumber: num, clusterDimension: clusterDimension, color: .red)
					}
				}
			}
			.padding(.horizontal, 4)
		}
		
	}
}





struct ClusterView: View {
	
	
	@Binding var pixels: [Pixel]
	let clusterNumber: Int
	let clusterDimension: Int
	let color: Color
	
	static let spacing:CGFloat = 2
	static let boxDimension:CGFloat = 9
	
	let columns = [
		GridItem(.fixed(boxDimension), spacing: spacing),
		GridItem(.fixed(boxDimension), spacing: spacing),
		GridItem(.fixed(boxDimension), spacing: spacing),
		GridItem(.fixed(boxDimension), spacing: spacing)
	]
	
	var body: some View {
		
		LazyVGrid(columns: columns, alignment: .center, spacing: ClusterView.spacing) {
			ForEach(pixels[clusterNumber*clusterDimension..<clusterDimension*(clusterNumber+1)], id: \.self) { pixel in
				Rectangle()
					.aspectRatio(1.0, contentMode: .fit)
					.border(color)
					.foregroundColor(pixel.isColored ? color:.clear)
			}
		}
		
	}
}

struct TotalView_Previews: PreviewProvider {
	static var previews: some View {
		TotalView()
	}
}
