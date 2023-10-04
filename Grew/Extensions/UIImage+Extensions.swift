//
//  UIImage+Extensions.swift
//  ChattingModule
//
//  Created by cha_nyeong on 2023/09/26.
//

import Foundation
import UIKit

extension UIImage {
    
    // StackOverFlow:
    func resize(to size: CGSize = CGSize(width: 300, height: 300)) -> UIImage? {
        
        let widthRatio  = size.width  / size.width
        let heightRatio = size.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(origin: .zero, size: newSize)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    
}
