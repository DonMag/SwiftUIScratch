//
//  TextViewWithScrollView.swift
//  CircleProg
//
//  Created by Don Mag on 4/30/21.
//

import SwiftUI

struct TextviewWithScrollview_Previews: PreviewProvider {
    static var previews: some View {
		TextviewWithScrollview()
    }
}

struct TextviewWithScrollview: View {
	@State var textHeight: CGFloat = 0

	var textFieldHeight: CGFloat {
		let minHeight: CGFloat = 30
		let maxHeight: CGFloat = 370
		
		if textHeight < minHeight {
			return minHeight
		}
		
		if textHeight > maxHeight {
			return maxHeight
		}
		
		return textHeight
	}

	@State private var textStyle = UIFont.TextStyle.body
	@State private var textForTextView = "Start fdgfhjdsgfdhsgfdsfg dsfg dsfgdsfh fh sf hdsjklf dhsjkfhsdjkfdhsjkfadhsfkds fdshfjkldsh fjkldsh fdshfdshfdsfhsfdsfh sf ewf g iuf herjkdsjkjvdhsvdshvdsv dshv ds vads vds hvsdvjkds vds hviuds  vhv disu ghdisuv g"

	var body: some View {
		ZStack {
			Color.red
				.ignoresSafeArea()
			ScrollView(.vertical) {
				VStack(alignment: .center) {
					
					DynamicHeightTextField(text: $textForTextView, height: $textHeight, textStyle: $textStyle)
						
//					TextView(text: $textForTextView, textStyle: $textStyle)
//						.padding(.horizontal)
//						.frame(width: 200, alignment: .center)
					
					//TextView(isEditable: .constant(false), text:  .constant(textForTextView), textStyle:$textStyle, didStartEditing: .constant(false),placeHolderText:"")
					//	.frame(width:300, height: 300)
					
					
					HStack {
						Button("Top") {
						}
						Button("Middle") {
							
						}
						Button("Bottom") {
						}
					}
					.background(Color.yellow)
				}
				.frame(width: 300, height: textFieldHeight)
			}
			.background(Color.orange)
		}
	}
}

struct DynamicHeightTextField: UIViewRepresentable {
	@Binding var text: String
	@Binding var height: CGFloat
	@Binding var textStyle: UIFont.TextStyle

	func makeUIView(context: Context) -> UITextView {
		let textView = UITextView()
		
		textView.font = UIFont.preferredFont(forTextStyle: textStyle)

		textView.isScrollEnabled = true
		textView.alwaysBounceVertical = false
		textView.isEditable = true
		textView.isUserInteractionEnabled = true
		
		textView.text = text
		textView.backgroundColor = UIColor.green
		
		context.coordinator.textView = textView
		textView.delegate = context.coordinator
		textView.layoutManager.delegate = context.coordinator
		
		return textView
	}
	
	func updateUIView(_ uiView: UITextView, context: Context) {
		uiView.text = text
	}
	
	
	func makeCoordinator() -> Coordinator {
		return Coordinator(dynamicSizeTextField: self)
	}
}

class Coordinator: NSObject, UITextViewDelegate, NSLayoutManagerDelegate {
	
	var dynamicHeightTextField: DynamicHeightTextField
	
	weak var textView: UITextView?
	
	
	init(dynamicSizeTextField: DynamicHeightTextField) {
		self.dynamicHeightTextField = dynamicSizeTextField
	}
	
	func textViewDidChange(_ textView: UITextView) {
		self.dynamicHeightTextField.text = textView.text
	}
	
//	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//		if (text == "\n") {
//			textView.resignFirstResponder()
//			return false
//		}
//		return true
//	}
	
	func layoutManager(_ layoutManager: NSLayoutManager, didCompleteLayoutFor textContainer: NSTextContainer?, atEnd layoutFinishedFlag: Bool) {
		
		DispatchQueue.main.async { [weak self] in
			guard let textView = self?.textView else {
				return
			}
			let size = textView.sizeThatFits(textView.bounds.size)
			if self?.dynamicHeightTextField.height != size.height {
				self?.dynamicHeightTextField.height = size.height
			}
		}
		
	}
}


struct TextView: UIViewRepresentable {
	
	@Binding var text: String
	@Binding var textStyle: UIFont.TextStyle
	
	func makeUIView(context: Context) -> UITextView {
		let textView = UITextView()
		
		textView.font = UIFont.preferredFont(forTextStyle: textStyle)
		textView.autocapitalizationType = .sentences
		textView.isSelectable = true
		textView.isUserInteractionEnabled = true
		textView.isScrollEnabled = false
		return textView
	}
	
	func updateUIView(_ uiView: UITextView, context: Context) {
		uiView.text = text
		uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
	}
}

struct zTextView: UIViewRepresentable {
	@Binding var isEditable:Bool
	@Binding var text: String
	@Binding var textStyle: UIFont.TextStyle
	@Binding var didStartEditing: Bool
	var placeHolderText: String = ""
	
	
	func makeUIView(context: Context) -> UITextView {
		let textView = UITextView()
		textView.delegate = context.coordinator
		textView.font = UIFont.preferredFont(forTextStyle: textStyle)
		textView.autocapitalizationType = .sentences
		textView.isSelectable = true
		textView.isUserInteractionEnabled = true
		//textView.isScrollEnabled = false
		textView.dataDetectorTypes = .all
		textView.textColor = .white
		textView.backgroundColor = .gray
		//textView.translatesAutoresizingMaskIntoConstraints = false
		return textView
	}
	
	func updateUIView(_ uiView: UITextView, context: Context) {
		uiView.text = text
		uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
		uiView.frame.size.width = 240
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator($text)
	}
	
	class Coordinator: NSObject, UITextViewDelegate {
		var text: Binding<String>
		
		init(_ text: Binding<String>) {
			self.text = text
		}
		
		func textViewDidChange(_ textView: UITextView) {
			DispatchQueue.main.async {
				self.text.wrappedValue = textView.text
			}
		}
	}
}
