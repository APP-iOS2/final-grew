//
//  FirestoreService.swift
//  Grew
//
//  Created by cha_nyeong on 10/5/23.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreService {
    // 리스너 생성
    private var listener: ListenerRegistration?
    
    func configure() {
        FirebaseApp.configure()
    }
    
    // 리스너 연결 + 쿼리 처리 + 레퍼런스 생성 값 가져오기
    func objects<T: FireCodable>(_ object: T.Type, reference: Reference, parameter: DataQuery? = nil) async throws -> [T] {
        guard let parameter else {
            let snapshot = try await reference.reference().getDocuments()
            let results = snapshot.documents.compactMap({ try? $0.data(as: T.self) })
            return results
        }
        let queryReference: Query
        switch parameter.mode {
        case .equal:
            queryReference = reference.reference().whereField(parameter.key, isEqualTo: parameter.value)
        case .lessThan:
            queryReference = reference.reference().whereField(parameter.key, isLessThan: parameter.value)
        case .moreThan:
            queryReference = reference.reference().whereField(parameter.key, isGreaterThan: parameter.value)
        case .contains:
            queryReference = reference.reference().whereField(parameter.key, arrayContains: parameter.value)
        }
        let snapshot = try await queryReference.getDocuments()
        let results = snapshot.documents.compactMap({ try? $0.data(as: T.self) })
        return results
    }
    
    func update<T: FireCodable>(_ object: T, reference: Reference) { reference.reference().document(object.id).setData(object.toDictionary, merge: true)
    }
    
    func objectWithListener<T: FireCodable>(_ object: T.Type, reference: Reference, parameter: DataQuery? = nil) async throws -> [T] {
        var results: [T] = []
        guard let parameter else {
            listener = reference.reference().addSnapshotListener({ (snapshot, _) in
                results = snapshot?.documents.compactMap({ try? $0.data(as: T.self) }) ?? []
            })
            return results
        }
        
        let queryReference: Query
        switch parameter.mode {
        case .equal:
            queryReference = reference.reference().whereField(parameter.key, isEqualTo: parameter.value)
        case .lessThan:
            queryReference = reference.reference().whereField(parameter.key, isLessThan: parameter.value)
        case .moreThan:
            queryReference = reference.reference().whereField(parameter.key, isGreaterThan: parameter.value)
        case .contains:
            queryReference = reference.reference().whereField(parameter.key, arrayContains: parameter.value)
        }
        listener = queryReference.addSnapshotListener({ (snapshot, _) in
            results = snapshot?.documents.compactMap({ try? $0.data(as: T.self) }) ?? []
        })
        return results
    }
    
    func stopObservers() {
        listener?.remove()
    }
    
    deinit {
        listener?.remove()
    }
    
    /*
    func delete<T>(_ objects: T.Type, reference: Reference, parameter: DataQuery, completion: @escaping CompletionObject<FirestoreResponse>) where T: FireCodable {
        let queryReference: Query
        switch parameter.mode {
        case .equal:
            queryReference = reference.reference().whereField(parameter.key, isEqualTo: parameter.value)
        case .lessThan:
            queryReference = reference.reference().whereField(parameter.key, isLessThan: parameter.value)
        case .moreThan:
            queryReference = reference.reference().whereField(parameter.key, isGreaterThan: parameter.value)
        case .contains:
            queryReference = reference.reference().whereField(parameter.key, arrayContains: parameter.value)
        }
        queryReference.getDocuments { (snap, error) in
            guard error.isNone else { completion(.failure); return }
            let batch = reference.reference().firestore.batch()
            snap?.documents.forEach({ (document) in
                batch.deleteDocument(document.reference)
            })
            batch.commit(completion: { (err) in
                guard err == nil else { completion(.failure); return }
                completion(.success)
            })
        }
    }
     */
    
}

extension FirestoreService {
    struct DataQuery {
        
        let key: String
        let value: Any
        let mode: Mode
        
        enum Mode {
            case equal
            case lessThan
            case moreThan
            case contains
        }
    }
    
    struct Reference {
        
        private let locations: [FirestoreCollectionReference]
        private let documentID: String
        
        init(location: FirestoreCollectionReference) {
            self.locations = [location]
            self.documentID = ""
        }
        
        init(first: FirestoreCollectionReference, second: FirestoreCollectionReference, id: String) {
            self.locations = [first, second]
            self.documentID = id
        }
        
        func reference() -> CollectionReference {
            let ref = Firestore.firestore()
            guard locations.count == 2 else {
                return ref.collection(locations.first!.rawValue)
            }
            return ref.collection(locations.first!.rawValue).document(documentID).collection(locations.last!.rawValue)
        }
    }
}
