//
//  CircleProgApp.swift
//  CircleProg
//
//  Created by Don Mag on 1/29/21.
//

import SwiftUI


@main
struct CircleProgApp: App {
	@StateObject private var timeObject = TimeManager()
	
    var body: some Scene {
        WindowGroup {
            //ContentView()
			//TotalView()
			//PickerTestView()
			//TextviewWithScrollview()
			//GradBars()
			//MapTestView()
			//ActivityCircleComponent()
			//ExpandableView()
			//TestLoaderView()
			//MaskScroll()
			//ScrollTestView()
			//ProfileActionButtonView()
			//ProfileContainerView()
			//CaptureView()
			//ChatView()
			//SecureParentView()
			//ListHeaders()
			//ImageAnim()
			//EmbedScrollView()
			//RandArray()
			//TextFiltering()
			//CustomField()
			//ImageMask()
			//StackSpace()
			//WithUIKitButton()
			//SafeTestView()
			//BotToTopView()
			//ImageMaskingView()
			TextTransition()
			//BoxesView().environmentObject(timeObject)
        }
    }
}
