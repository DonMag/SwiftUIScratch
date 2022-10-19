//
//  SafeTestView.swift
//  CircleProg
//
//  Created by Don Mag on 10/17/22.
//

import SwiftUI

struct SafeTestView: View {
    var body: some View {
		ZStack {
			Color.black
			UIKitView()
		}
		//.ignoresSafeArea(edges: .top)
		.safeAreaInset(edge: .top) {
			Text("TOP")
				.frame(width: 280.0, height: 200.0, alignment: .top)
				//.frame(minHeight: 200)
				.background(Color.cyan.opacity(0.5))
		}
    }
}

struct SafeTestView_Previews: PreviewProvider {
    static var previews: some View {
        SafeTestView()
    }
}

struct UIKitView: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> some UIViewController { ViewController() }
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
	
	class ViewController: UIViewController {
		let bgView = UILabel()
		let safeView = UILabel()
		
		override func viewDidLoad() {
			bgView.backgroundColor = .red.withAlphaComponent(0.5)
			self.view.addSubview(bgView)
			safeView.backgroundColor = .green.withAlphaComponent(0.5)
			self.view.addSubview(safeView)
		}
		
		override func viewWillLayoutSubviews() {
			super.viewWillLayoutSubviews()
			self.bgView.frame = self.view.bounds
			self.safeView.frame = self.view.safeAreaLayoutGuide.layoutFrame
		}

		override func viewDidLayoutSubviews() {
			super.viewDidLayoutSubviews()
			self.bgView.frame = self.view.bounds
			self.safeView.frame = self.view.safeAreaLayoutGuide.layoutFrame
		}
	}
}
