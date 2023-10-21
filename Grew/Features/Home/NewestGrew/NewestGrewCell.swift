//
//  NewestGrewCell.swift
//  Grew
//
//  Created by 김효석 on 10/17/23.
//

import SwiftUI

struct NewestGrewCell: View {
    
    @EnvironmentObject var grewViewModel: GrewViewModel
    let grew: Grew
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: grew.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 135, height: 180)
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
            .overlay(
                
                HStack {
                    VStack(alignment: .leading, spacing: 3) {
                        Spacer()
                        Text(grewViewModel.categoryName(grew.categoryIndex))
                            .font(.c2_R)
                        Text(grew.title)
                            .font(.c1_R)
                        HStack(spacing: 3) {
                            Image(systemName: "person.2.fill")
                            Text("\(grew.currentMembers.count) / \(grew.maximumMembers)")
                        }
                        .font(.c2_R)
                    }
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
                    .foregroundColor(.white)
                    Spacer()
                }
                
            )
        }
    }
}

#Preview {
    NewestGrewCell(grew: Grew(
        id: "id",
        categoryIndex: "소개팅",
        categorysubIndex: "802",
        title: "아날로그 소지품 소개팅",
        description: "...",
        imageURL: "https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Z3JvdXB8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=900&q=60",
        isOnline: false,
        location: "",
        gender: .any,
        minimumAge: 30,
        maximumAge: 30,
        maximumMembers: 10,
        currentMembers: [],
        isNeedFee: false,
        fee: 0,
        createdAt: Date(),
        heartTapped: 0))
        .environmentObject(GrewViewModel())
}
