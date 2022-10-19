//
//  ImageMask.swift
//  CircleProg
//
//  Created by Don Mag on 9/9/22.
//

import SwiftUI

struct ImageMask: View {
	
	var img: UIImage = UIImage(named: "sampleBackground") ?? UIImage()
	var msk: UIImage = UIImage(named: "msk3") ?? UIImage()
	
    var body: some View {
        Text("sampleBackground")

//		Image("sampleBackground")
//			.resizable()
//			.frame(width: 300, height: 300)
//			.mask(
//				Image("msk2")
//			)

		Text("This is a red view with some text") // 1
			.padding(50)
			.background(Color.red)
			.mask { // 2
				Image("msk3") // 3
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 350)
					.luminanceToAlpha() // 4
					.fixedSize() // 5
			}

		
		Image("sampleBackground")
			.resizable()
			.frame(width: 300, height: 300)
			.mask { // 2
				Image("msk3") // 3
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 350)
					.luminanceToAlpha()
					.fixedSize() // 5
			}

//		Image(uiImage: img.gsMask(msk))
//			.resizable()
//			.frame(width: 300, height: 300)

//		Image("sampleBackground")
//			.resizable()
//			.frame(width: 300, height: 300)

	}
}

struct ImageMask_Previews: PreviewProvider {
    static var previews: some View {
        ImageMask()
    }
}

extension UIImage {
	func gsMask(_ msk: UIImage) -> UIImage {
		guard let srcCG = self.cgImage, let mskCG = msk.cgImage else { return UIImage() }
		let c = srcCG.masked(by: mskCG)
		return UIImage(ciImage: c)
	}
}
extension CGImage {
	
	func masked(by cgMask: CGImage) -> CIImage {
		let selfCI = CIImage(cgImage: self)
		let maskCI = CIImage(cgImage: cgMask)
		
		let maskFilter = CIFilter(name: "CIMaskToAlpha")
		maskFilter?.setValue(maskCI, forKey: "inputImage")
		let scaleFilter = CIFilter(name: "CILanczosScaleTransform")
		scaleFilter?.setValue(maskFilter?.outputImage, forKey: "inputImage")
		scaleFilter?.setValue(selfCI.extent.height / maskCI.extent.height, forKey: "inputScale")
		let filter: CIFilter! = CIFilter(name: "CIBlendWithAlphaMask")
		filter.setValue(selfCI, forKey: "inputBackgroundImage")
		let maskOutput = scaleFilter?.outputImage
		filter.setValue(maskOutput, forKey: "inputMaskImage")
		let outputImage = filter.outputImage!
		return outputImage
	}
}

