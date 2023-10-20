//
//  Stump.swift
//  Grew
//
//  Created by 김효석 on 10/20/23.
//

import Foundation

struct Stump: Identifiable, Codable {
    var id: String = UUID().uuidString
    let stumpMemberId: String
    let name: String
    let hours: String
    let minimumMembers: String
    let maximumMembers: String
    let isNeedDeposit: Bool
    let deposit: String
    let location: String
    let phoneNumber: String
    let imageURLs: [String]
}
