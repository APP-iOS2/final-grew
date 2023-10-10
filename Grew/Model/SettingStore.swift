//
//  SettingStore.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/05.
//

import Foundation

struct Setting: Identifiable {
    var id: UUID = UUID()
    var name: String
}

var intros: [Setting] = [
    Setting(name: "공지사항"),
    Setting(name: "FAQ"),
    Setting(name: "고객센터"),
    Setting(name: "이벤트")
]
