//
//  Padding.swift
//  CircleProg
//
//  Created by Don Mag on 10/28/21.
//

import SwiftUI

struct Padding: View {
	var urlToOpen = "test"
	var title = "The Title\nLine 2"
	var subInformation = "Sub Info"
	var description = "The description"
	var picture = "picture"
    var body: some View {
		VStack(alignment: .leading) {
			Image(systemName: "camera")
				//.data(url: URL(string: picture)!)
				.resizable()
				.scaledToFill()
				.frame(width: UIScreen.main.bounds.width * 0.8)
				//.maxHeight(215)
				.clipped()
			Group {
				HStack {
					Text(title)
						.bold()
						.font(.system(size: 20, weight: .bold))
						.padding(.vertical, 5)
					Spacer()
				}
				HStack {
					Text(subInformation)
						.font(.system(size: 17, weight: .semibold))
						.foregroundColor(Color.red)
						.padding(.bottom, 5)
					Spacer()
				}
				HStack {
					Text(description)
						.padding(.bottom, 2)
						.foregroundColor(Color.gray)
					Spacer()
				}
			}.padding(.horizontal)
			Rectangle()
			//DestinationAd()
				.frame(width: UIScreen.main.bounds.width * 0.8, height: 50)
				.padding(.bottom, 5)
			Link(destination: URL(string: urlToOpen)!, label: {
				HStack {
					Spacer()
					Text("See more")
						.padding(.vertical, 5)
					Spacer()
				}.background(Color.blue)
				.cornerRadius(10)
			}).padding(.horizontal, 10)
			.padding(.bottom, 10)
		}.frame(width: UIScreen.main.bounds.width * 0.8)
		.background(Color.white)
		.cornerRadius(20)

    }
}

struct Padding_Previews: PreviewProvider {
    static var previews: some View {
        Padding()
    }
}
