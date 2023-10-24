//
//  ImagePicker.swift
//  Grew
//
//  Created by Chloe Chung on 2023/09/22.
//

import SwiftUI
import FirebaseStorage

struct ImagePicker: UIViewControllerRepresentable {
    var path: String?
    @Binding var imageString: String
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.image = uiImage
                uploadImage(image: uiImage)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func uploadImage(image: UIImage) {
            let storage = Storage.storage()
            let storageRef = storage.reference()
            
            if let imageData = image.jpegData(compressionQuality: 0.5) {
                let imageName = UUID().uuidString
                
                let imageRef = storageRef.child(parent.path ?? "").child("\(imageName).jpg")
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                
                imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
                    if error != nil {
                        print(error)
                    } else {
                        imageRef.downloadURL { (url, error) in
                            if let downloadURL = url?.absoluteString {
                                self.parent.imageString = downloadURL
                            } else {
                                print("can't download image")
                            }
                        }
                    }
                }
            } else {
                print("can't upload image")
            }
        }
    }
}
