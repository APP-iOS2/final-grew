//
//  Grew.swift
//  CircleRecruitment
//
//  Created by KangHo Kim on 2023/09/21.
//

import Foundation

struct Grew: Identifiable, Codable {
    var id: String = UUID().uuidString
    /// 1차 카테고리
    let categoryIndex: String
    /// 2차 카테고리
    let categorysubIndex: String
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
    var currentMembers: [String] = []
    /// 활동비 여부
    var isNeedFee: Bool
    /// 활동비
    var fee: Int = 0
    /// 모임 생성 시간
    var createdAt: String {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: "ko")
        
        return dateFormatter.string(from: nowDate)
    }
    /// 좋아요 눌린 횟수
    var heartTapped: Int = 0
}


