//
//  Profile.swift
//  Grew
//
//  Created by Chloe Chung on 2023/09/21.
//

import Foundation

struct Grew: Identifiable, Codable {
    let id: String = UUID().uuidString
    /// 카테고리
    let category: String
    /// 모임 이름
    let title: String
    /// 모임 설명
    var description: String
    /// 모임 썸네일 이미지
    var imageURL: String = "https://image.newsis.com/2023/05/25/NISI20230525_0001274814_web.jpg"
    /// 온라인, 오프라인 여부
    var isOnline: Bool
    /// 오프라인 주소
    var location: String = ""
    /// 활동 지역 (ex: 구로구, 수원시)
    var district: String {
        let locationArray = location.split(separator: " ")
        if locationArray.count > 1 {
            return String(locationArray[1])
        } else if isOnline == true {
            return "온라인"
        } else {
            return "장소 미정"
        }
    }
    /// 멤버 성별
    var gender: Gender
    /// 멤버 최소 나이
    var minimumAge: Int // pickerStyle(.wheel)
    /// 멤버 최대 나이
    var maximumAge: Int // pickerStyle(.wheel)
    /// 최대 인원 수
    var maximumMembers: Int // 키보드타입 number ,textField -> 정규식 검사 Int인지 확인
    /// 멤버
    var currentMembers: [String]
    /// 활동비 여부
    var isNeedFee: Bool
    /// 활동비
    var fee: Int = 0
}



//enum ProfileThreadFilter: CaseIterable {
//    case myGroup
//    case myGroupSchedule
//}


class GroupStore: ObservableObject {
    @Published var groups: [Grew] = [
        Grew(category: "", title: "🌼우리 지금 만나🌼", description: "", imageURL: "https://health.chosun.com/site/data/img_dir/2021/10/29/2021102901055_0.jpg", 
             isOnline: false, location: "도봉구", gender: .female, minimumAge: 20,
             maximumAge: 35, maximumMembers: 100, currentMembers: [""], isNeedFee: false),
        Grew(category: "", title: "멋쟁이보드게임", description: "", imageURL: "https://mblogthumb-phinf.pstatic.net/20160925_281/healthyself_1474812496323dQged_JPEG/1.jpg?type=w800", 
             isOnline: false, location: "용산구", gender: .female, minimumAge: 20,
             maximumAge: 35, maximumMembers: 100, currentMembers: [""], isNeedFee: false),
        Grew(category: "", title: "뚝섬유원지🌿", description: "", imageURL: "https://mblogthumb-phinf.pstatic.net/20160413_23/fashionygood_1460535302266ViLIB_JPEG/attachImage_2709871601.jpeg?type=w800", isOnline: false, 
             gender: .any, minimumAge: 10, maximumAge: 50, maximumMembers: 200,
             currentMembers: [""], isNeedFee: false),
        Grew(category: "", title: "화성갈끄니까🪐테슬라 존버", description: "", isOnline: true, 
             gender: .any, minimumAge: 18, maximumAge: 60, maximumMembers: 200,
             currentMembers: [""], isNeedFee: false),
        Grew(category: "", title: "🏄‍♀️서핑스키보드 ⛵️요트 ⛳️골프승마", description: "", imageURL: "https://cdn.allets.com/500/2018/08/21/500_319745_1534829711.jpeg", 
             isOnline: false, gender: .male, minimumAge: 26, maximumAge: 50, maximumMembers: 30,
             currentMembers: [""], isNeedFee: true, fee: 150000),
        Grew(category: "", title: "금요일엔 모각코👩🏻‍💻", description: "", imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMfVLDnL1xUy1sIRHejgMUu2l-bHJKG7JJtYWfjM3Hj556t8s4MIX86ioy1eSVNdyPJMM&usqp=CAU", 
             isOnline: false, gender: .any, minimumAge: 20, maximumAge: 40, maximumMembers: 10,
             currentMembers: [""], isNeedFee: true, fee: 10000)
    ]
    
    var currentGroup: Grew {
        groups.first!
    }
}

