//
//  GroupDetailConfig.swift
//  Grew
//
//  Created by cha_nyeong on 10/12/23.
//

import Foundation
import UIKit

struct GroupDetailConfig {
    var chatText: String = ""
    var sourceType: UIImagePickerController.SourceType?
    var selectedImage: UIImage?
    var showOptions: Bool = false
    
    mutating func clearForm() {
        chatText = ""
        selectedImage = nil
    }
    
    var isValid: Bool {
        !chatText.isEmptyOrWhiteSpace || selectedImage != nil
    }
}
