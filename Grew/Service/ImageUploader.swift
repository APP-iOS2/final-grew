//
//  ImageUploader.swift
//  Grew
//
//  Created by cha_nyeong on 10/20/23.
//

import Firebase
import FirebaseStorage
import SwiftUI

struct ImageUploader {
    static func uploadImage (path: String, image: UIImage) async throws -> String? {
        
        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return nil }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        let ref = Storage.storage().reference(withPath: path)
        
        do {
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            print(url)
            return url.absoluteString
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
