//
//  Extensions.swift
//  ANF Code Test
//
//  Created by E-Cartale on 08/12/2022.
//

import Foundation
import UIKit

extension UIImage{

    func resizeHighImage(image:UIImage)->UIImage {
            let size = image.size.applying(CGAffineTransform(scaleX: 0.5, y: 0.5))
            let hasAlpha = false
            let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
            UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
            image.draw(in: CGRect(origin: .zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return scaledImage!

    }
    
    func getAspectRatioAccordingToiPhones(cellImageFrame:CGSize,downloadedImage: UIImage)->CGFloat {
            let widthOffset = downloadedImage.size.width - cellImageFrame.width
            let widthOffsetPercentage = (widthOffset*100)/downloadedImage.size.width
            let heightOffset = (widthOffsetPercentage * downloadedImage.size.height)/100
            let effectiveHeight = downloadedImage.size.height - heightOffset
            return(effectiveHeight)
    }
}

extension String{
    
    func getHttps() -> String{
        return self.replacingOccurrences(of: "http", with: "https")
    }
}
