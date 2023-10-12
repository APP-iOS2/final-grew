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
            
            VStack(alignment: .leading) {
                Text("보드게임")
                Text("멋쟁이보드게임")
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text("온라인")
                }
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
                    
                    Group {
                        Image(systemName: "person.2.fill")
                        Text("5/20")
                    }
                }
            }.padding(.horizontal, 20)
            
            Spacer()
        }
    }
}

#Preview {
    MapListItemView()
}
