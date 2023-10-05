//
//  PostModel.swift
//  Grew
//
//  Created by 정유진 on 2023/10/05.
//

import Foundation

struct TempGrew: Identifiable, Codable {
    
    let id: String = UUID().uuidString
    /// 카테고리
    let category: String
    /// 모임 이름
    let title: String
    /// 모임 설명
    var description: String
    /// 모임 썸네일 이미지
    var imageURL: String = "https://image.newsis.com/2023/05/25/NISI20230525_0001274814_web.jpg"
    /// 온라인, 오프라인 여부
    var isOnline: Bool
    /// 오프라인 주소
    var location: String = ""
    /// 활동 지역 (ex: 구로구, 수원시)
    var district: String {
        let locationArray = location.split(separator: " ")
        if locationArray.count > 1 {
            return String(locationArray[1])
        } else if isOnline == true {
            return "온라인"
        } else {
            return "장소 미정"
        }
    }
    /// 멤버 성별
    var gender: Gender
    /// 멤버 최소 나이
    var minimumAge: Int // pickerStyle(.wheel)
    /// 멤버 최대 나이
    var maximumAge: Int // pickerStyle(.wheel)
    /// 최대 인원 수
    var maximumMembers: Int // 키보드타입 number ,textField -> 정규식 검사 Int인지 확인
    /// 멤버
    var currentMembers: [String]
    /// 활동비 여부
    var isNeedFee: Bool
    /// 활동비
    var fee: Int = 0
}

/// 성별
enum Gender: String, CaseIterable, Codable {
    case any = "누구나"
    case female = "여자"
    case male = "남자"
}
