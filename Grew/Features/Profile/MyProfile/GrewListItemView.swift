//
//  GrewListItemView.swift
//  Grew
//
//  Created by daye on 10/21/23.
//

import SwiftUI

struct GrewListItemView: View {
    // 참여한 유저 이미지 매핑해야함
    let grew: Grew
    
    var body: some View {
        HStack {
            ZStack {
                AsyncImage(url: URL(string: grew.imageURL), content: { image in
                    image
                        .resizable()
                }, placeholder: {
                    ProgressView()
                })
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Button(action: {
                    
                }, label: {
                    
                })
            }.frame(width: 100, height: 100)
                .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                Text(grew.categoryIndex)
                    .font(.c2_L)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 3)
                    .background(Color.LightGray1)
                    .cornerRadius(20)
                    
                    
                Text(grew.title)
                    .font(.b2_B)
                    .padding(.top, 1)
                Text(grew.description)
                    .font(.c2_B)
                    .foregroundColor(.gray)
                    .padding(.top, 1)
                
                HStack {
                    Group {
                        ForEach(0..<5, content: { index in
                            AsyncImage(url: URL(string: ""), content: { image in
                                image
                            }, placeholder: {
                                ProgressView()
                            })
                        }).padding(.horizontal, -10)
                    }
                    Spacer()
                    Group {
                        Image(systemName: "person.2.fill")
                        Text("\(grew.currentMembers.count)/\(grew.maximumMembers)")
                    }.font(.c2_R)
                }.padding(.top, 1)
                    .padding(.leading, 10)
            }
                
            
            Spacer()
        }
    }
}

/*
#Preview {
    GrewListItemView(grew: Grew(from: <#Decoder#>))
}*/
