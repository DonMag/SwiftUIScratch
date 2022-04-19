//
//  ProfileActionButtonView.swift
//  CircleProg
//
//  Created by Don Mag on 4/16/22.
//

import SwiftUI

struct ProfileActionButtonView: View {
	
	var body: some View {
		ZStack {
		Text("This is text")
			.background(Color.yellow)
			.frame(width: 320.0, height: 240.0, alignment: .center)
		}
		.background(Color.orange)
		.cornerRadius(40.0)
	}
}

struct ProfileActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
		ProfileActionButtonView()
    }
}
