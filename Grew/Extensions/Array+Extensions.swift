//
//  Array+Extensions.swift
//  ChattingModule
//
//  Created by cha_nyeong on 2023/09/26.
//

import Foundation

//안전하게 추출
extension Array {
    public subscript(safe index: Int) -> Element? {
        get {
            indices ~= index ? self[index] : nil
        }
        set(newValue) {
            if let newValue = newValue, indices.contains(index) {
                self[index] = newValue
            }
        }
    }
}
