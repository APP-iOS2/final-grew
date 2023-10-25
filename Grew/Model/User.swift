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
    @DocumentID var id: String?
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
    /// 찜한 그루 배열 Grew id 삽입
    var favoritGrew: [String]
}

extension User {
    static let dummyUser = User(nickName: "더미", email: "더미", gender: "남", dob: "19900101", searchHistory: [], isStumpMember: false, favoritGrew: [""])
}

/// 성별
enum Gender: String, CaseIterable, Codable {
    case any = "누구나"
    case female = "여자"
    case male = "남자"
    
    var genderIndex: Int {
        switch self {
        case .any:
            return 0
        case .female:
            return 1
        case .male:
            return 2
        }
    }
}
enum ProfileThreadFilter: Int, CaseIterable, Identifiable {
    case myGroup
    case myGroupSchedule
    case savedGrew

    var title: String {
        switch self {
        case .myGroup: return "내 그루"
        case .myGroupSchedule: return "내 그루 일정"
        case .savedGrew: return "찜한 그루"
        }
    }

    var id: Int { return self.rawValue }
}
