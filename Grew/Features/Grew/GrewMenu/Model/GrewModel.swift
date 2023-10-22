//
//  File.swift
//  Grew
//
//  Created by 마경미 on 22.10.23.
//

import Foundation

struct EditGrew: Identifiable, Codable {
    var id: String = UUID().uuidString
    var title: String
    /// 모임 설명
    var description: String
    /// 모임 썸네일 이미지
    var imageURL: String = "https://image.newsis.com/2023/05/25/NISI20230525_0001274814_web.jpg"
    /// 온라인, 오프라인 여부
    var isOnline: Bool
    /// 오프라인 주소
    var location: String = ""
    /// 위도
    var latitude: String?
    /// 경도
    var longitude: String?
    /// geohash
    var geoHash: String?
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
    var minimumAge: String
    /// 멤버 최대 나이
    var maximumAge: String
    /// 최대 인원 수
    var maximumMembers: String
    /// 활동비 여부
    var isNeedFee: Bool
    /// 활동비
    var fee: String
}

extension EditGrew {
    static var defaultGrew: EditGrew {
        return EditGrew(title: "", description: "", isOnline: false, gender: .any, minimumAge: "", maximumAge: "", maximumMembers: "", isNeedFee: false, fee: "")
    }
}


enum Location {
    case offline
    case online
}

enum Fee {
    case exist
    case free
}

enum GrewEditContent {
    case setting
    case grewEdit
    case grootEdit
}
