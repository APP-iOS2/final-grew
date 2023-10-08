//
//  AnnouncementModel.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/05.
//

import Foundation

struct Announcement: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var context: String
    var createdAt: Double = Date().timeIntervalSince1970
    var category: String
    
    var createdDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        
        let dateCreatedAt = Date(timeIntervalSince1970: createdAt)
        
        return dateFormatter.string(from: dateCreatedAt)
    }
}
