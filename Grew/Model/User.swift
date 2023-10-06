//
//  User.swift
//  Grew
//
//  Created by 김종찬 on 2023/09/21.
//

import Foundation

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
    /// 검색 내역
    var searchHistory: [String] = []
}

enum Gender: String, CaseIterable, Codable {
    case female = "여성"
    case male = "남성"
}
