//
//  ImagePicker.swift
//  Grew
//
//  Created by cha_nyeong on 10/13/23
//

import Foundation
import SwiftUI

struct ChatImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.dismiss) private var dismiss
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ChatImagePickerCoordinator
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeCoordinator() -> ChatImagePicker.Coordinator {
        return ChatImagePickerCoordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class ChatImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        var imagePicker: ChatImagePicker
        
        init(_ imagePicker: ChatImagePicker) {
            self.imagePicker = imagePicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imagePicker.image = uiImage
            }
            
            imagePicker.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            imagePicker.dismiss()
        }
        
    }
}
