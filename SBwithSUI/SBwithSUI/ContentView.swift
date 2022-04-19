//
//  ContentView.swift
//  SBwithSUI
//
//  Created by Don Mag on 4/2/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		ZStack(alignment: .center){
			Rectangle()
				.frame(width: 200, height: 75)
				.cornerRadius(10)
				.foregroundColor(.white)
			Circle()
				.stroke(lineWidth:5)
				.foregroundColor(.red)
				.frame(width: 75, height: 75, alignment: .leading)
				.background(
					Image("tempimage")
						.resizable()
				)
		}
	}
	
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
