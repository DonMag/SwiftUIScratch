//
//  Pickers.swift
//  CircleProg
//
//  Created by Don Mag on 2/3/23.
//

import SwiftUI

public extension UIApplication {
	func currentUIWindow() -> UIWindow? {
		let connectedScenes = UIApplication.shared.connectedScenes
			.filter { $0.activationState == .foregroundActive }
			.compactMap { $0 as? UIWindowScene }
		
		let window = connectedScenes.first?
			.windows
			.first { $0.isKeyWindow }
		
		return window
		
	}
}

enum SomeCases: String, CaseIterable, Identifiable {
	case first = "First"
	case second = "Second"
	case third = "Third"
	case fourth = "Fourth"
	
	public var id: String { rawValue }
}


struct Pickers: View {
		@State private var someCases: SomeCases = .first
		@State private var someDate: Date = .init()
	
	@State private var showPicker: Bool = false
	
//		var body: some View {
//			VStack (spacing: 150){
//				Picker("First picker", selection: $someCases) {
//					ForEach(SomeCases.allCases) { someCase in
//						Text(someCase.rawValue)
//							.fontWeight(.bold)
//					}
//				}
//
//				Spacer()
//
//				DatePicker("Date picker", selection: $someDate)
//					.onTapGesture {
//						print("on tap")
//						UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
//					}
//
//				})
//			}
//			.padding()
//		}

//	var body: some View {
//		VStack (spacing: 200){
//			Picker("First picker", selection: $someCases) {
//				ForEach(SomeCases.allCases) { someCase in
//					Text(someCase.rawValue)
//						.fontWeight(.bold)
//				}
//			}
//			.pickerStyle(.inline)
//
//			DatePicker("Date picker", selection: $someDate)
//				.onTapGesture {
//					print("on tap")
//				}
//		}
//		.padding()
//	}

	var body: some View {
		ZStack(alignment: .top) {
			if showPicker {
				Picker("First picker", selection: $someCases) {
					ForEach(SomeCases.allCases) { someCase in
						Text(someCase.rawValue)
							.fontWeight(.bold)
					}
				}
				.pickerStyle(.inline)
				.frame(width: 200.0, height: 200.0, alignment: .center)
			}
			VStack (spacing: 200) {
				Button("First", action: {
					showPicker.toggle()
				})
				
				DatePicker("Date picker", selection: $someDate)
					.onTapGesture {
						print("on tap")
					}
			}
			.padding()
		}
	}
//	@State private var isShow = true
//
//	var body: some View {
//		ZStack {
//			Color.pink
//				.edgesIgnoringSafeArea(.all)
//			if isShow {
//				Text("Hello, SwiftUI!")
//					.font(.system(size: 56, weight: .heavy))
//			}
//
//			VStack {
//				Spacer()
//				Button("Show / Hide") {
//					withAnimation {
//						isShow.toggle()
//					}
//				}.foregroundColor(.black)
//			}
//		}
//	}

}

struct Pickers_Previews: PreviewProvider {
    static var previews: some View {
        Pickers()
    }
}

struct PickerPopover: View {
	var pickerOptions: [String]
	var width: CGFloat
	var height: CGFloat
	@Binding var showPicker: Bool
	@Binding var selectedPickerOption: Int
	@State var localState : Int = 0 //<< Here your local State
	
	func selectOption() {
		self.selectedPickerOption = localState //<< Sync the binding with the local State
		withAnimation {
			showPicker.toggle()
		}
	}
	
	func cancel() {
		//<< do nothing here
		withAnimation {
			showPicker.toggle()
		}
	}
	
	var body: some View {
		VStack {
			Picker(
				selection: $localState,
				label: Text("")
			) {
				ForEach(0 ..< pickerOptions.count) {
					Text(self.pickerOptions[$0])
				}
			}
			//.pickerStyle(WheelPickerStyle())
			
			Button(action: cancel) {
				Text("Cancel")
			}
			
			Button(action: selectOption) {
				Text("Select")
			}
		}
		.transition(.move(edge: .bottom))
		.onAppear {
			self.localState = selectedPickerOption // << set inital value here
		}
	}
}
