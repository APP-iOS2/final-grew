//
//  PostViewModel.swift
//  Grew
//
//  Created by 정유진 on 2023/10/05.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class TempGrewViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var grewList: [TempGrew] = []
    
    func fetchGrew() {
        
        db.collection("grews").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents, error == nil else {
                if let error = error { print(error) }
                return
            }
            
            var fetchData = [TempGrew]()
            
            for document in documents {
                do {
                    let temp = try document.data(as: TempGrew.self)
                    fetchData.append(temp)
                } catch {
                    print("파베 패치 에러 났어요.\n\(error)")
                }
            }
            self.grewList = fetchData
        }
    }
}
