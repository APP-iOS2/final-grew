//
//  DateService.swift
//  ChattingModule
//
//  Created by cha_nyeong on 10/2/23.
//

import Foundation

final class DateService {
    static let shared = DateService()
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        return formatter
    }()
    
    private init() {}
    
    func format(_ date: Date) -> String {
        dateFormatter.dateFormat = "yyyy/mm/dd"
        return dateFormatter.string(from: date)
    }
    
    func grewFormat(_ date: Date) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: "ko")
        
        return dateFormatter.string(from: date)
    }
    
    func createDateFormat(_ date: Date) -> String {
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
    
    func lastMessageDateFormat(_ date: Date) -> String {
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: date)
    }
    func lastMessageFormat(_ date: Date) -> String {
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "a hh:mm"
        
        return dateFormatter.string(from: date)
    }
    func grewCellDateFormat(_ date: Date) -> String {
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
}
