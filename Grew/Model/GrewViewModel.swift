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
    
    func fetchGrew() {
            db.collection("grews").getDocuments { snapshot, error in
                guard let documents = snapshot?.documents, error == nil else {
                    if let error = error { print(error) }
                    return
                }
                
            var fetchData: [Grew] = []
            
            for document in documents {
                do {
                    let temp = try document.data(as: Grew.self)
                    fetchData.append(temp)
                } catch {
                    print("파베 패치 에러 났어요.\n\(error)")
                }
            }
            self.grewList = fetchData
        }
    }
}
