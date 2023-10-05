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

struct SubCategory: Identifiable, Codable {
    let id, name: String
}
