//
//  Schedule.swift
//  Grew
//
//  Created by daye on 10/17/23.
//
import SwiftUI

struct Schedule: Identifiable, Decodable, Encodable {
    var id: String = UUID().uuidString
    /// 스케쥴 아이디
    var gid: String
    /// 그루아이디
    var scheduleName: String
    /// 모임이름
    var date: Date
    /// 날짜, 시간
    var maximumMember: Int
    /// 정원
    var participants: [String]
    /// 현재 참여자
    var fee: String?
    /// 참가비
    var location: String?
    /// 주소
    var color: String
    /// hex
}
