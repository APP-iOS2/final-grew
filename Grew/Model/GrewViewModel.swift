//
//  GrewViewModel.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/05.
//
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

class GrewViewModel: ObservableObject {
    @Published var grewList: [Grew] = []

    private let db = Firestore.firestore()
    
    func addGrew(_ grew: Grew) {
        do {
            _ = try db.collection("grews").addDocument(from: grew)
        } catch {
            print("Error: \(error)")
        }
    }
}
