//
//  Bubble.swift
//  ChatTestProject
//
//  Created by daye on 2023/09/25.
//

import Foundation

enum Bubble: Int, CaseIterable, Identifiable {
    case my = 0
    case other = 1
    case admin = 2
    
    var title: String {
        switch self {
        case .my: return "사용자"
        case .other: return "다른 사용자"
        case .admin: return "관리자"
        }
    }
    
    var id: Int { return self.rawValue }
}
