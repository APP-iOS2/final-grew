//
//  Category.swift
//  Grew
//
//  Created by 윤진영 on 2023/10/05.
//

import Foundation

// JSON 구조체
struct GrewCategory: Identifiable, Codable {
    let id, name, imageString: String
    let subCategories: [SubCategory]
}

struct SubCategory: Identifiable, Codable {
    let id, name: String
}

// 선택된 카테고리 ID
struct Selection {
    /// 선택된 1차 카테고리 ID
    var categoryID: String?
    /// 선택된 2차 카테고리 ID
    var subCategoryID: String?
}
