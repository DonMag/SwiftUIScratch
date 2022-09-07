//
//  CustomField.swift
//  CircleProg
//
//  Created by Don Mag on 9/1/22.
//

import SwiftUI

struct CustomField: View {

	//@ObservedObject var forumCommentInputViewModel = ForumCommentInputViewModel()
	
	@State var composeForumMessage: String = ""

	@State var height: CGFloat = 100
	
//	init(forumPost: ForumPost) {
//		forumCommentInputViewModel.forumPost = forumPost
//	}
	
	func forumCommentAction() {
		if !composeForumMessage.isEmpty {
			var msg = composeForumMessage
			composeForumMessage = ""
			print("success comment post", msg)
//			forumCommentInputViewModel.addForumComments(text: composeForumMessage) {
//				self.composeForumMessage = ""
//				print("success comment post")
//			}
		} else {
			print("not successful post")
		}
	}
	
	@State var txt = ""
	
	var body: some View {
		
		
		ResizeableTextField(txt: $composeForumMessage, height: self.$height)
			.frame(height: self.height < 150 ? self.height : 150)
			.padding(.horizontal)
			.background(Color.white)
			.cornerRadius(8)
		
		
		Button(action: forumCommentAction) {
			Image(systemName: "paperplane")
				.resizable()
				.frame(width: 23, height: 23)
				.foregroundColor(Color(red: 134/255, green: 134/255, blue: 134/255))
				.padding(.top, 2)
				.padding(.leading, 12)
				.padding(.trailing, 15)
		}
	}
	
}

struct CustomField_Previews: PreviewProvider {
    static var previews: some View {
        CustomField()
    }
}


struct ResizeableTextField: UIViewRepresentable {
	
	@Binding var txt : String
	@Binding var height : CGFloat
	
	func makeCoordinator() -> Coordinator {
		
		return ResizeableTextField.Coordinator(parent1: self)
	}
	
	func makeUIView(context: Context) -> UITextView {
		
		let view = UITextView()
		view.isEditable = true
		view.isScrollEnabled = true
		view.text = "Write something..."
		view.font = .systemFont(ofSize: 18)
		view.backgroundColor = .clear
		view.textColor = .gray
		view.delegate = context.coordinator
		return view
	}
	
	func updateUIView(_ uiView: UITextView, context: Context) {
		
		DispatchQueue.main.async {
			
			
			self.height = uiView.contentSize.height
			
		}
	}
	
	class Coordinator : NSObject, UITextViewDelegate {
		
		var parent : ResizeableTextField
		
		init(parent1 : ResizeableTextField) {
			
			parent = parent1
		}
		
		func textViewDidBeginEditing(_ textView: UITextView) {
			
			if self.parent.txt == "" {
				
				textView.text = ""
				textView.textColor = .black
			}
		}
		
		func textViewDidEndEditing(_ textView: UITextView) {
			
			if self.parent.txt == "" {
				
				textView.text = "Write something..."
				textView.textColor = .gray
			}
		}
		
		func textViewDidChange(_ textView: UITextView) {
			
			DispatchQueue.main.async {
				
				self.parent.height = textView.contentSize.height
				self.parent.txt = textView.text
			}
		}
		
	}
}
