//
//  MapListItemView.swift
//  Grew
//
//  Created by 마경미 on 10.10.23.
//

import SwiftUI

struct MapListItemView: View {
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://cdn.011st.com/11dims/resize/600x600/quality/75/11src/product/1563685899/B.jpg?108000000"), content: { image in
                image
                    .resizable()
            }, placeholder: {
                ProgressView()
            })
            .frame(width: 84, height: 84)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Spacer(minLength: 12)
            
            VStack(alignment: .leading) {
                CategoryView(isSmall: true, text: "문화예술")
                Text("보드게임")
                    .font(.b2_B)
                    .foregroundColor(Color.Black)
                Text("멋쟁이보드게임")
                    .font(.c2_B)
                    .foregroundColor(Color.DarkGray1)
                HStack {
                    Group {
                        ForEach(0..<5, content: { index in
                            AsyncImage(url: URL(string: "https://image.news1.kr/system/photos/2019/9/6/3810898/article.jpg/dims/quality/80/optimize"), content: { image in
                                image
                                    .resizable()
                            }, placeholder: {
                                ProgressView()
                            })
                            .frame(width: 24, height: 24)
                            .clipShape(.capsule)
                        }).padding(.horizontal, -5)
                    }
                    
                    Spacer()
                    
                    Group {
                        Image(systemName: "person.2.fill")
                            .font(Font.custom("SF Pro", size: 10))
                            .foregroundColor(Color.DarkGray1)
                        Text("5/20")
                            .font(.c2_B)
                            .foregroundColor(Color.DarkGray1)
                    }
                }
            }
        }.padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}


#Preview {
    MapListItemView()
}
