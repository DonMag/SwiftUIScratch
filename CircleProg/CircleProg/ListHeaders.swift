//
//  ListHeaders.swift
//  CircleProg
//
//  Created by Don Mag on 6/16/22.
//

import SwiftUI

struct ListHeaders: View {
	// 1.
	let europeanCars = ["Audi","Renault","Ferrari", "E4", "E5", "E6", "E7", "E8", "E9", "E10",]
	let asianCars = ["Honda","Nissan","Suzuki", "A4", "A5", "A6", "A7", "A8", "A9", "A10", "A14", "A15", "A16", "A17", "A18", "A19", "A20",]
	
	var body: some View {
		NavigationView {
			List {
				
				Section(header: Text("European")
					.fontWeight(.bold)
					.frame(maxWidth: .infinity, alignment: .center)
				) {
					ForEach(0 ..< europeanCars.count) {
						Text(self.europeanCars[$0])
					}
				}
				
				Section(header: Text("Asian")
					.fontWeight(.bold)
					.frame(maxWidth: .infinity, alignment: .center)
				) {
					ForEach(0 ..< asianCars.count) {
						Text(self.asianCars[$0])
					}
				}
				

//
//				// 2.
//				Section(header:
//							HStack {
//					Image(systemName: "car")
//					Text("European Cars")
//						.fontWeight(.bold)
//						.frame(maxWidth: .infinity, alignment: .center)
//
//				},
//						// 4.
//						 {
//					ForEach(0 ..< europeanCars.count) {
//						Text(self.asianCars[$0])
//					}
//				}
//				// 3.
//				Section(header:
//							HStack {
//					Image(systemName: "car")
//					Text("Asian Cars")
//						.fontWeight(.bold)
//						.frame(maxWidth: .infinity, alignment: .center)
//
//				}
//						// 4.
//						, footer: Text("This is a example list of a few car brands").font(.footnote))  {
//					ForEach(0 ..< asianCars.count) {
//						Text(self.asianCars[$0])
//					}
//				}
				
			}
			.listStyle(.plain)
			.navigationBarTitle("Cars")
		}
		
	}
}

struct ListHeaders_Previews: PreviewProvider {
    static var previews: some View {
        ListHeaders()
    }
}
