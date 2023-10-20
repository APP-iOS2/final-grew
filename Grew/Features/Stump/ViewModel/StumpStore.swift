//
//  StumpStore.swift
//  Grew
//
//  Created by 김효석 on 10/20/23.
//

import FirebaseFirestore
import FirebaseStorage
import Foundation

final class StumpStore: ObservableObject {
    
    @Published var stumps: [Stump] = []
    
    private let db = Firestore.firestore()
    
    func addStumpMember(_ stumpMember: StumpMember) throws {
        do {
            try db.collection("stumpMembers").addDocument(from: stumpMember)
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
    
    func addStump(_ stump: Stump) throws {
        do {
            try db.collection("stumps").addDocument(from: stump)
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
    
    @MainActor
    func fetchStumps() async {
        do {
            let snapshot = try await db.collection("stumps").getDocuments()
            
            var fetchData: [Stump] = []
            
            for document in snapshot.documents {
                do {
                    let temp = try document.data(as: Stump.self)
                    fetchData.append(temp)
                } catch {
                    print("Fetch stumps error: \(error)")
                }
            }
            self.stumps = fetchData
        } catch {
            print("Error fetching stumps: \(error)")
        }
    }
    
    /// 이미지를 Firestore Storage의 원하는 경로로 업로드
    func uploadImage(image: UIImage, path: String, completion: @escaping (String?) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            let imageName = UUID().uuidString
            
            let imageRef = storageRef.child(path).child("\(imageName).jpg")
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    completion(nil)
                } else {
                    imageRef.downloadURL { (url, error) in
                        if let downloadURL = url?.absoluteString {
                            completion(downloadURL)
                        } else {
                            completion(nil)
                        }
                    }
                }
            }
        } else {
            completion(nil)
        }
    }
    
    func updateStumpMember(userId: String) async {
        await fetchStumps()
        
        let stumpIds = stumps
            .filter { $0.stumpMemberId == userId }
            .map { $0.id }
        
        do {
            let snapshot = try await db.collection("stumpMembers").whereField("userId", isEqualTo: userId).getDocuments()
            
            for document in snapshot.documents {
                try await self.db.collection("stumpMembers").document(document.documentID).updateData([
                    "stumpIds" : stumpIds
                ])
            }
        } catch {
            print("Error updating stumpMembers: \(error)")
        }
    }
}
