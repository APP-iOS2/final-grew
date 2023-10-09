//
//  UIImagePickerController.SourceType+Extensions.swift
//  ChattingModule
//
//  Created by cha_nyeong on 2023/09/26.
//

import Foundation
import UIKit

extension UIImagePickerController.SourceType: Identifiable {
    public var id: Int {
        switch self {
        case .camera:
            return 1
        case .photoLibrary:
            return 2
        case .savedPhotosAlbum:
            return 3
        @unknown default:
            return 4
        }
    }
}
