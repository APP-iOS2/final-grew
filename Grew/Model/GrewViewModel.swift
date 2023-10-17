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
    @Published var categoryDisplayName = ""
    @Published var categorysubDisplayName = ""
    @Published var meetingTitle = ""
    @Published var isOnline = true
    @Published var gender: Gender = .any
    @Published var minimumAge = 20
    @Published var maximumAge = 20
    @Published var maximumMembers = ""
    @Published var fee = ""
    @Published var isNeedFee = false

    
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
    
    // 선택된 1차 카테고리 이름 가져오기
        func selectedCategoryName() -> String {
            if let category = categoryArray.first(where: { $0.id == selectedCategoryId }) {
                return category.name
            }
            return ""
        }
    // 선택된 2차 카테고리 이름 가져오기
        func selectedSubCategoryName() -> String {
            if let category = categoryArray.first(where: { $0.id == selectedCategoryId }) {
                if let subCategory = category.subCategories.first(where: { $0.id == selectedSubCategoryId }) {
                    return subCategory.name
                }
            }
            return ""
        }
    /// cell에 사용할 카테고리 이름 가져오기
    func categoryName(_ firstIndex: String, _ secondIndex: String) -> String {
        
        if let category = categoryArray.first(where: { $0.id == firstIndex }) {
            if let subCategory = category.subCategories.first(where: { $0.id == secondIndex }) {
                return subCategory.name
            }
        }
        return ""
    }
    
    func fetchJsonData() {
        do {
            // "Categories.json" 파일에서 JSON 데이터를 가져와서 categoryArray 배열에 저장
            categoryArray = try loadJson("Categories.json")
        } catch{
            print("Error Occured")
        }
    }

    // JSON파일의 이름을 넣어서 GrewCategory타입으로 디코딩 하는 함수 JSON -> Swift (디코딩)
    func loadJson(_ filename: String) throws -> [GrewCategory] {
        let data: Data
        
        // 앱에 저장된 파일 중 filename파일의 URL 찾기
        guard let file: URL = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("\(filename)not found.")
        }
        
        do {
            // 파일을 데이터로 가져와서 저장
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Could not load \(filename)not found.")
        }
        
        do {
            // 데이터로 로드가 되면 GrewCategory타입 배열로 디코딩 Json -> Swift
            return try JSONDecoder().decode([GrewCategory].self, from: data)
        }
        catch {
            fatalError("Unable to parse \(filename): \(error)")
        }
    }
    
    func popularFilter(grewList: [Grew]) -> [Grew] {
        
        let tempList = grewList.sorted(by: {$0.heartTapped > $1.heartTapped})
        
        if tempList.count < 5 {
            return tempList
        } else {
            var resultList: [Grew] = []
            for index in 0 ..< 5 {
                resultList.append(tempList[index])
            }
            return resultList
        }
    }
    
}
