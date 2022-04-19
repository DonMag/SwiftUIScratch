//
//  ExpandableView.swift
//  CircleProg
//
//  Created by Don Mag on 12/9/21.
//

import SwiftUI

struct ExpandableView: View {
	@State var expanded = false

	var body: some View {
		VStack {

			// Red view
			Rectangle()
				.fill(Color.red)
				.frame(width: 300, height: 80, alignment: .top)
			
			HStack {
				
				GeometryReader { geo in
					// Green view (your CustomDropdown)
					Rectangle()
						.fill(Color.green)
						.frame(width: 100, height: expanded ? 300 : 80, alignment: .top)
						.onTapGesture {
							print(geo.frame(in: .local))
							print(geo.frame(in: .global))
							expanded.toggle()
						}
				}
			}
			.frame(width: 300, height: 120, alignment: .top)
			// bring HStack above following elements (Blue Rectangle)
			.zIndex(1)
			
			// Blue view (your MyButton)
			Rectangle()
				.fill(Color.blue)
				.frame(width: 200, height: 100, alignment: .top)
			
		}
		
	}


}

struct ExpandableView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandableView()
    }
}
