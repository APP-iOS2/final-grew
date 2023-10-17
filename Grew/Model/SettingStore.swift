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

var appInfo: [Setting] = [
    Setting(name: "오픈소스 라이센스"),
    Setting(name: "개발자 정보"),
    Setting(name: "문의하기")
]

var grewtoegi: [Setting] = [
    Setting(name: "그루터기 멤버 신청하기"),
    Setting(name: "그루터기 등록하기"),
    Setting(name: "그루터기 보기"),
]
