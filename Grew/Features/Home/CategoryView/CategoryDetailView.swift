//
//  CategoryDetailView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/05.
//

import SwiftUI

struct CategoryDetailView: View {
    
    let grewList: [Grew]
    @State var tempGrewList: [Grew] = []
    let tempCategoryList: [String] = ["전시", "영화", "공연/연극", "뮤지컬/오페라", "콘서트", "페스티벌", "고궁/문화재"]
    
    var body: some View {
        VStack {
            
            
            // 서브뷰로 만들어 넣기 (extention)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(tempCategoryList, id: \.self) { list in
                        
                        Button {
                            
                        } label: {
                            Text("\(list)")
                                .foregroundStyle(Color.white)
                                .padding(5)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(Color(red: 37, green: 197, blue: 120))
                        )
                    }
                }
            }
            .scrollIndicators(.hidden)
            // 좌우에 패딩주기
            .padding(.bottom, 12)
            ScrollView {
                GrewListView(grewList: grewList)
            }
        }
    }
}

#Preview {
    CategoryDetailView(grewList: [])
}
