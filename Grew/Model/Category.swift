//
//  Category.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/05.
//

import Foundation

struct GrewCategory: Identifiable, Codable {
    let id, name, imageString: String
    let subCategories: [SubCategory]
}

struct SubCategory: Identifiable, Codable, Hashable {
    let id, name: String
}

// 선택된 카테고리 ID
struct Selection {
    /// 선택된 1차 카테고리 ID
    var categoryID: String?
    /// 선택된 2차 카테고리 ID
    var subCategoryID: String?
}


enum GrewMainCategory: CaseIterable, Identifiable {
    var id: GrewMainCategory { self }
    
    case artsAndCulture
    case activity
    case travel
    case cookingAndCrafting
    case foodAndDrinking
    case gamingAndEntertainment
    case musicAndInstruments
    case carAndMotorcycle
    case photographyAndVideo
    case neighborhoodAndSocial
    case study
    case languages
    
    var categoryForKorean: String {
        switch self {
        case .artsAndCulture:
            return "문화예술"
        case .activity:
            return "액티비티"
        case .travel:
            return "여행"
        case .cookingAndCrafting:
            return "요리/제조"
        case .foodAndDrinking:
            return "푸드/드링크"
        case .gamingAndEntertainment:
            return "게임/오락"
        case .musicAndInstruments:
            return "음악/악기"
        case .carAndMotorcycle:
            return "차/오토바이"
        case .photographyAndVideo:
            return "사진/영상"
        case .neighborhoodAndSocial:
            return "동네/친목"
        case .study:
            return "스터디"
        case .languages:
            return "외국어"
        }
    }
    
    var categoryForIndex: String {
        switch self {
        case .artsAndCulture:
            return "100"
        case .activity:
            return "200"
        case .travel:
            return "300"
        case .cookingAndCrafting:
            return "400"
        case .foodAndDrinking:
            return "500"
        case .gamingAndEntertainment:
            return "600"
        case .musicAndInstruments:
            return "700"
        case .carAndMotorcycle:
            return "800"
        case .photographyAndVideo:
            return "900"
        case .neighborhoodAndSocial:
            return "1000"
        case .study:
            return "1100"
        case .languages:
            return "1200"
        }
    }
}
