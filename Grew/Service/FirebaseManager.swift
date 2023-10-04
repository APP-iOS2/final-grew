//
//  FirebaseManager.swift
//  ChattingModule
//
//  Created by cha_nyeong on 2023/09/27.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

/// 파이어베이스 서비스화
class FirebaseManager {
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    private init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
    }
    
    func saveFireStoreData<T:Codable>(collection: String, data: T) async throws {
        do {
            try firestore.collection(collection).addDocument(from: data)
            print("Success in \(#function) : collection is \(collection)")
        } catch let error {
            print("Error in \(#function) : \(error.localizedDescription)" )
            throw error
        }
    }
    
    func saveFireStoreData<T:Codable>(path: String, documentId: String, data: T) async throws {
        do {
            try firestore.collection(path).addDocument(from: data)
            print("Success in \(#function) : collection is \(path)")
        } catch let error {
            print("Error in \(#function) : \(error.localizedDescription)" )
            throw error
        }
    }
    
    func saveFireStoreData<T:Codable>(collection: String, documentId: String, subCollection: String, data: T) async throws {
        do {
            try firestore.collection(collection).addDocument(from: data)
            print("Success in \(#function) : collection is \(collection)")
        } catch let error {
            print("Error in \(#function) : \(error.localizedDescription)" )
            throw error
        }
    }
}
