//
//  ChatSegment.swift
//  ChatTestProject
//
//  Created by daye on 2023/09/25.
//
import Foundation

enum ChatSegment: Int, CaseIterable, Identifiable {
    case personal = 0
    case group = 1
    
    var title: String {
        switch self {
        case .group: return "그룹"
        case .personal: return "개인"
        }
    }
    
    var id: Int { return self.rawValue }
}
