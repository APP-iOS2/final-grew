//
//  GrewViewModel.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/05.
//
import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import GeoFire

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
    @Published var location = ""
    @Published var latitude = "" // 위도
    @Published var longitude = ""  // 경도
    @Published var gender: Gender = .any
    @Published var minimumAge = 20
    @Published var maximumAge = 20
    @Published var maximumMembers = ""
    @Published var fee = ""
    @Published var isNeedFee = false
    
    @Published var selectedGrew: Grew = Grew.defaultGrew
    @Published var editGrew: EditGrew = EditGrew.defaultGrew
    @Published var showingSheet: Bool = false
    @Published var sheetContent: GrewEditContent = .grewEdit
    @Published var isShowingToolBarSheet: Bool = false
    
    private let db = Firestore.firestore()
    
    func addGrew(_ grew: Grew) {
        var grew = grew
        grew.geoHash = {
            if let doubleLatitude = Double(grew.latitude),
               let doubleLongitude = Double(grew.longitude) {
                return GFUtils.geoHash(forLocation: CLLocationCoordinate2D(latitude: doubleLatitude, longitude: doubleLongitude))
            }
            
            return ""
        }()
        
        do {
            _ = try db.collection("grews").addDocument(from: grew)
            fetchGrew()
        } catch {
            print("Error: \(error)")
        }
    }
    
    func joinGrew(_ grew: Grew) {
        db.collection("grews").whereField("id", isEqualTo: grew.id).getDocuments { snapshot, error in
            if let error {
                print("Error: \(error)")
            } else if let snapshot {
                for document in snapshot.documents {
                    self.db.collection("grews").document(document.documentID).updateData([
                        "currentMembers" : grew.currentMembers
                    ]) { error in
                        if let error {
                            print("Grew Update Error: \(error)")
                        } else {
                            self.fetchGrew()
                        }
                    }
                }
            }
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
    
    /// NewestGrewCell에 사용할 카테고리 이름 가져오기
    func categoryName(_ categoryIndex: String) -> String {
        
        if let category = categoryArray.first(where: { $0.id == categoryIndex}) {
            return category.name
        }
        return ""
    }
    
    /// GrewCelViewl에 사용할 카테고리 이름 가져오기
    func subCategoryName(_ firstIndex: String, _ secondIndex: String) -> String {
        
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
        
        let tempList = grewList.sorted(by: {$0.heartCount > $1.heartCount})

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
    
    func newestFilter(grewList: [Grew]) -> [Grew] {
        
        let tempList = grewList.sorted(by: { $0.createdAt > $1.createdAt})
        
        if tempList.count < 10 {
            return tempList
        } else {
            var resultList: [Grew] = []
            for index in 0 ..< 10 {
                resultList.append(tempList[index])
            }
            return resultList
        }
    }
    
    func addGrewMember(grewId: String, userId: String) {
        if var grew = grewList.first(where: { $0.id == grewId }) {
            grew.currentMembers.append(userId)
            joinGrew(grew)
        }
    }
    
    func withdrawGrewMember(grewId: String, userId: String) {
        if var grew = grewList.first(where: { $0.id == grewId }) {
            if let index = grew.currentMembers.firstIndex(of: userId) {
                grew.currentMembers.remove(at: index)
                joinGrew(grew)
            }
        }
    }
    
    // 그루 아이디는 동일 했다 근데 업데이트가 안됐다
    func heartTapping(gid: String) {
    
        let flag = UserStore.shared.checkFavorit(gid: gid)
        
        for grew in grewList {
            if grew.id == gid {
                var currentGrew = grew
                if flag {
                    currentGrew.heartCount -= 1
                } else {
                    currentGrew.heartCount += 1
                }
                heartUpdateGrew(currentGrew)
                break
            }
        }
    }
    
    func heartUpdateGrew(_ grew: Grew) {
        db.collection("grews").whereField("id", isEqualTo: grew.id).getDocuments { snapshot, error in
            if let error {
                print("Error: \(error)")
            } else if let snapshot {
                for document in snapshot.documents {
                    self.db.collection("grews").document(document.documentID).updateData([
                        "heartCount" : grew.heartCount
                    ]) { error in
                        if let error {
                            print("Grew Update Error: \(error)")
                        } else {
                            self.fetchGrew()
                        }
                    }
                }
            }
        }
    }
    
    /// 프로필에서 사용할 현재 유저의 찜한 그루 가져오기
    func favoritGrew() -> [Grew] {
        var resultList: [Grew] = []
        if let currentUser = UserStore.shared.currentUser {
           
            for gid in currentUser.favoritGrew {
                let grew = grewList.filter {
                    $0.id == gid
                }
                resultList.append(contentsOf: grew)
            }
            return resultList
        }
        return resultList
    }
    
    
    
}

// static class Method
extension GrewViewModel {
    private static let db = Firestore.firestore()
    
    static func requestAndReturnGrew(grewId: String) async -> Grew? {
        let doc = db.collection("grews").document(grewId)
        do {
            let grew = try await doc.getDocument(as: Grew.self)
            return grew
        } catch {
            print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
            return nil
        }
    }
    
    /*
     static func requestGrewByUser(user: User) async -> [Grew]? {
     let doc = db.collection("grews").document()
     do {
     let grew = try await doc.getDocument(as: Grew.self)
     return grew
     } catch {
     print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
     return nil
     }
     
     }*/
}

// 그루 수정하기
extension GrewViewModel {
    func makeEditGrew() {
        var isOnline: OnOff {
            if selectedGrew.isOnline {
                return .online
            } else {
                return .offline
            }
        }
        
        var fee: Fee {
            if selectedGrew.isNeedFee {
                return .exist
            } else {
                return .free
            }
        }
        
        self.editGrew = .init(
            id: selectedGrew.id,
            title: selectedGrew.title,
            description: selectedGrew.description,
            imageURL: selectedGrew.imageURL,
            isOnline: isOnline,
            location: selectedGrew.location,
            latitude: selectedGrew.latitude,
            longitude: selectedGrew.longitude,
            geoHash: selectedGrew.geoHash, 
            gender: selectedGrew.gender,
            minimumAge: String(selectedGrew.minimumAge),
            maximumAge: String(selectedGrew.maximumAge),
            maximumMembers: String(selectedGrew.maximumMembers),
            isNeedFee: fee,
            fee: String(selectedGrew.fee)
        )
    }
    
    func updateGrew() {
        var geoHash: String
           if let latitude = CLLocationDegrees(latitude),
           let longitude = CLLocationDegrees(longitude) {
            geoHash = GFUtils.geoHash(forLocation: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        } else {
            geoHash = ""
        }

        db.collection("grews").document(selectedGrew.id).updateData([
            "title": editGrew.title,
            "description": editGrew.description,
            "isOnline": editGrew.isOnline.onOffBool,
            "location": editGrew.location,
            "gender": editGrew.gender.rawValue,
            "minimumAge": editGrew.minimumAge as? Int ?? 0,
            "maximumAge": editGrew.maximumAge as? Int ?? 100,
            "maximumMembers": editGrew.maximumMembers as? Int ?? 100,
            "isNeedFee": editGrew.isNeedFee.feeBool,
            "fee": editGrew.fee as? Int ?? 0,
            "imageURL": editGrew.imageURL,
            "latitude": editGrew.latitude,
            "longitude": editGrew.longitude,
            "geoHash": geoHash
        ])
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
}
