//
//  GrewListItemView.swift
//  Grew
//
//  Created by daye on 10/21/23.
//

import SwiftUI

struct GrewListItemView: View {
    var body: some View {
        HStack {
            ZStack {
                AsyncImage(url: URL(string: "https://cdn.011st.com/11dims/resize/600x600/quality/75/11src/product/1563685899/B.jpg?108000000"), content: { image in
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
                Text("소개팅")
                    .font(.c2_L)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 3)
                    .background(Color.LightGray1)
                    .cornerRadius(20)
                    
                    
                Text("아날로그 소지품 소개팅")
                    .font(.b2_B)
                    .padding(.top, 1)
                Text("아날로그 소지품 소개팅")
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
                        Text("5/20")
                    }.font(.c2_R)
                }.padding(.top, 1)
                    .padding(.leading, 10)
            }
                
            
            Spacer()
        }
    }
}

#Preview {
    GrewListItemView()
}
