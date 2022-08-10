//
//  ChatView.swift
//  CircleProg
//
//  Created by Don Mag on 5/10/22.
//

import SwiftUI

struct xChatView: View {
	@State var chatTextInput: String = ""
	@State var oldChatValue: String = ""
	@State var newChatValue: String = ""
	
	var body: some View {
		VStack {
			TextEditor(text: $chatTextInput)
				.onChange(of: chatTextInput) { newValue in
					print("o:", oldChatValue, "n:", newChatValue, "c:", chatTextInput)
					if chatTextInput != oldChatValue {
						oldChatValue += "a"
						newChatValue += newValue.last.map{String($0)}!
						chatTextInput = oldChatValue
					}
				}
		}
	}
}

struct SecureParentView: View{
	@State var text: String = "qwerty"
	var body: some View{
		VStack{
			Text(text)
			ChatView(text: $text)
		}
	}
}
//The custom field
struct ChatView: View {
	@Binding var text: String
	//The proxy handles the masking
	var proxy: Binding<String>{
		Binding(get: {
			return text.map { _ in "a" }.joined()
//			return text.map { _ in "\u{272A}" }.joined()
		}, set: { value in
			//Not needed here because the TextField is focused
		})
	}
	@FocusState private var focusedField: Int?
	var body: some View {
		//This is for size. The 3 layers have to match so the cursor doesn't look off
		Text(text).lineLimit(1)
			.opacity(0)
		//Put a true secure field on top that has invisible text/dots
			.overlay(
				SecureField("actual", text: $text)
					.foregroundColor(Color.clear)
					.focused($focusedField, equals: 1)
					.minimumScaleFactor(0.2)
				
			)
			.background(
				//This will sit on below but will look like it is on top
				//It will reduce in size to match lettering
				Text(proxy.wrappedValue)
					.lineLimit(1)
					.minimumScaleFactor(0.2)
					.foregroundColor(Color(UIColor.label))
					.opacity(1)
			)
			.foregroundColor(Color(UIColor.clear))
			.onTapGesture {
				focusedField = 1
			}
	}
	
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
		SecureParentView()
    }
}
