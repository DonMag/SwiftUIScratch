//
//  TextFiltering.swift
//  CircleProg
//
//  Created by Don Mag on 8/26/22.
//

import SwiftUI
import Combine

struct TextFiltering: View {

	@State private var userName = ""
	@State private var codeNumber = ""

	var body: some View {
		HStack {
			TextField("Username", text: $userName)
				.background(Color.cyan)
				.onReceive(Just(userName)) { newValue in
					let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789._-"
					let filtered = newValue.filter { allowedCharacters.contains($0) }
					if filtered != newValue {
						self.userName = filtered
					}
				}
			Spacer()
			TextField("Code", text: $codeNumber)
				.background(Color.yellow)
				.onReceive(Just(codeNumber)) { newValue in
					let allowedCharacters = "0123456789"
					let filtered = newValue.filter { allowedCharacters.contains($0) }
					if filtered != newValue {
						self.codeNumber = filtered
					}
				}
		}
	}

}

struct TextFiltering_Previews: PreviewProvider {
    static var previews: some View {
        TextFiltering()
    }
}
