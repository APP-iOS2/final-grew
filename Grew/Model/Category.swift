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
