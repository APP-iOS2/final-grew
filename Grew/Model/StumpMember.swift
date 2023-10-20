//
//  StumpMember.swift
//  Grew
//
//  Created by 김효석 on 10/20/23.
//

import Foundation

struct StumpMember: Identifiable, Codable {
    var id: String = UUID().uuidString
    let userId: String
    let name: String
    let businessNumber: String
    let phoneNumber: String
    let businessImageURL: String
    let stumpIds: [String]
}
