//
//  TempHomeCategory.swift
//  Grew
//
//  Created by 정유진 on 2023/10/05.
//

import Foundation
import SwiftUI


enum TempHomeCategory: String, CaseIterable{
    
    case all = "전체"
    case activity = "운동"
    case foodDrink = "음식"
    case travel = "여행"
    case dance = "춤"
    case animal = "동물"
    case music = "음악"
    case game = "게임"
    case drive = "드라이브"
    case meeting = "미팅"
    
    
    var image: Image {
        switch self {
        case .all: return Image(systemName: "person")
        case .activity: return Image(systemName: "figure.run")
        case .foodDrink: return Image(systemName: "fork.knife")
        case .travel: return Image(systemName: "figure.hiking")
        case .dance: return Image(systemName: "figure.socialdance")
        case .animal: return Image(systemName: "pawprint.fill")
        case .music: return Image(systemName: "headphones")
        case .game: return Image(systemName: "gamecontroller.fill")
        case .drive: return Image(systemName: "car.fill")
        case .meeting: return Image(systemName: "figure.2.arms.open")
            
        }
    }
}

