//
//  User.swift
//  Grew
//
//  Created by cha_nyeong on 10/5/23.
//

import Foundation
// 0922 설아, 종찬
struct User: Identifiable {
    /// 유저의 Auth 고유 아이디.
    var id: String = UUID().uuidString
    /// 유저 이름
    var nickName: String
        /// 이메일
        var email: String
    /// 성별
    var gender: Gender
    /// 생년월일
    var dob: String
    /// 프로필이미지
    var userImageURLString: String?
        /// 자기소개
    var introduce: String?
        /// [0923] 검색 내역 (설아, 효석)
    var searchHistory: [String] = []
}

// 0925 종찬 - 프로토콜 추가
enum Gender: String, CaseIterable, Codable {
    case female = "여성"
    case male = "남성"
}
