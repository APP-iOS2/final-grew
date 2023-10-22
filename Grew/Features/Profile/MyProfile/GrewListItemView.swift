//
//  GrewListItemView.swift
//  Grew
//
//  Created by daye on 10/21/23.
//

import SwiftUI

struct GrewListItemView: View {
    
    let grew: Grew
    @EnvironmentObject var grewViewModel: GrewViewModel
    
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
                Text(grewViewModel.subCategoryName(grew.categoryIndex, grew.categorysubIndex))
                    .font(.c2_R)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
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
                    /*
                    Group {
                        ForEach(0..<5, content: { index in
                            AsyncImage(url: URL(string: ""), content: { image in
                                image
                            }, placeholder: {
                                ProgressView()
                            })
                        }).padding(.horizontal, -10)
                    }*/
                    Spacer()
                    Group {
                        // 모임 이미지
                        Image(systemName: "person.2.fill")
                            .padding(.trailing, -5)
                            .font(.c2_B)
                            .foregroundStyle(Color.DarkGray1)
                        // 모임 정원
                        HStack {
                            Text("\(grew.currentMembers.count)")
                            Text("/")
                                .padding(.horizontal, -5)
                            Text("\(grew.maximumMembers)")
                                .padding(.leading, -5)
                        }
                        .font(.c2_B)
                        .foregroundStyle(Color.DarkGray1)
                    }
                    
                }

            }
            Spacer()
        }.padding(.horizontal, 5)
            .padding(.vertical, 2)
    }
}

