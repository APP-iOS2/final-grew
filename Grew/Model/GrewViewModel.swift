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
    @Published var categoryArray: [GrewCategory] = []
    @Published var selectedCategoryIndex = 0
    @Published var selectedSubCategoryIndex = 0
    @Published var selectedCategoryId = ""
    @Published var selectedSubCategoryId = ""
    @Published var meetingTitle = ""
    @Published var isOnline = true
    @Published var gender: Gender = .any
    @Published var minimumAge = 0
    @Published var maximumAge = 0
    @Published var maximumMembers = ""
    @Published var fee = ""
    @Published var isNeedFee: Bool = false
    
    private let db = Firestore.firestore()
    
    func addGrew(_ grew: Grew) {
        do {
            _ = try db.collection("grews").addDocument(from: grew)
            fetchGrew()
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
    
    func fetchJsonData() {
        do {
            categoryArray = try loadJson("Categories.json")
        } catch{
            print("Error Occured")
        }
    }

    func loadJson(_ filename: String) throws -> [GrewCategory] {
        let data: Data
        
        guard let file: URL = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("\(filename)not found.")
        }
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Could not load \(filename)not found.")
        }
        do {
            return try JSONDecoder().decode([GrewCategory].self, from: data)
        }
        catch {
            fatalError("Unable to parse \(filename): \(error)")
        }
    }
}
