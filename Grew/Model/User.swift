//
//  User.swift
//  Grew
//
//  Created by Chloe Chung on 2023/09/27.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

struct User: Identifiable, Codable, Equatable, Hashable {
    /// 유저의 Auth 고유 아이디.
    @DocumentID var id: String? /*= UUID().uuidString*/
    /// 유저 이름
    var nickName: String
    /// 이메일
    var email: String
    /// 성별
    var gender: String
    /// 생년월일
    var dob: String
    /// 프로필이미지
    var userImageURLString: String?
    /// 자기소개
    var introduce: String?
    /// 검색 내역
    var searchHistory: [String]
    /// 그루터기 멤버 여부
    var isStumpMember: Bool
}

extension User {
    static let dummyUser = User(nickName: "더미", email: "더미", gender: "남", dob: "19900101", searchHistory: [], isStumpMember: false)
}

// class UserStore: ObservableObject {
//    @Published var users: [User] = [
//        User(nickName: "설아", email: "seolah@grew.com", gender: .female, dob: "20000101", userImageURLString: "https://i.pinimg.com/564x/e9/9c/d7/e99cd7e40ebd13170431cfb76588a281.jpg", introduce: "싱싱미역 아니구 심신미약..", searchHistory: []),
//        User(nickName: "jin0", email: "jin0@grew.com", gender: .female, dob: "19970123", userImageURLString: "https://i.pinimg.com/564x/d9/f9/7b/d9f97bf7a781afe05394aa277e4a1112.jpg", searchHistory: []),
//        User(nickName: "서코", email: "seoko@grew.com", gender: .male, dob: "19901231", searchHistory: []),
//        User(nickName: "차녕", email: "chan0@grew.com", gender: .male, dob: "19970831", userImageURLString: "https://i.pinimg.com/564x/9b/f3/22/9bf3220472aecf308ab5c3f5a1f6a7cd.jpg", searchHistory: [])
//    ]
//
//    var currentUser: User {
//        users.first!
//    }
// }
/// 성별
enum Gender: String, CaseIterable, Codable {
    case any = "누구나"
    case female = "여자"
    case male = "남자"
}
enum ProfileThreadFilter: Int, CaseIterable, Identifiable {
    case myGroup
    case myGroupSchedule
    case savedGrew
//    case mentions

    var title: String {
        switch self {
        case .myGroup: return "내 그루"
        case .myGroupSchedule: return "내 그루 일정"
        case .savedGrew: return "찜한 그루"
        }
    }

    var id: Int { return self.rawValue }
}
