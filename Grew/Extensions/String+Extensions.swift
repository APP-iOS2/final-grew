//
//  String+Extensions.swift
//  ChattingModule
//
//  Created by cha_nyeong on 2023/09/26.
//

import Foundation

extension String {
    public func stringToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self) ?? Date()
    }
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
