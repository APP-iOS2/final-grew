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
    case system = 2
    
    var title: String {
        switch self {
        case .my: return "사용자"
        case .other: return "다른 사용자"
        case .system: return "시스템"
        }
    }
    
    var id: Int { return self.rawValue }
}
