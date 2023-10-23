//
//  Schedule.swift
//  Grew
//
//  Created by daye on 10/17/23.
//
import SwiftUI

struct Schedule: Identifiable, Decodable, Encodable, Equatable {
    /// 스케쥴 아이디
    var id: String = UUID().uuidString
    /// 그루아이디
    var gid: String
    /// 모임이름
    var scheduleName: String
    /// 날짜, 시간
    var date: Date
    /// 정원
    var maximumMember: Int
    /// 현재 참여자
    var participants: [String]
    /// 참가비
    var fee: String?
    /// 주소
    var location: String?
    /// 위도
    var latitude: String?
    /// 경도
    var longitude: String?
    /// hex
    var color: String
    
    var grewCellDateString: String {
        DateService.shared.grewCellDateFormat(date)
    }
}
