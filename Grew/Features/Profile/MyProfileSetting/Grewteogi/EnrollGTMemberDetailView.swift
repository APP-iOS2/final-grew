//
//  EnrollGTMemberDetailView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/18.
//

import SwiftUI

struct EnrollGTMemberDetailView: View {
    var body: some View {
        @State var name: String = ""
        
        NavigationStack {
            VStack(alignment: .leading) {
                
                Text("그루터기장 이름(사업자 이름)")
                    .padding(.horizontal, 20)
                    
                
                RoundedRectangle(cornerRadius: 7)
                    .frame(height: 45)
                    .foregroundStyle(Color.LightGray2)
                    .overlay(alignment: .leading) {
                        TextField("예) 김그루", text: $name)
                            .padding()
                            .foregroundColor(Color.BackgroundGray)
                    }
                    .padding(.horizontal, 20)
                
                
                Text("사업자등록번호")
                    .padding(.horizontal, 20)
                    
                
                RoundedRectangle(cornerRadius: 7)
                    .frame(height: 45)
                    .foregroundStyle(Color.LightGray2)
                    .overlay(alignment: .leading) {
                        TextField("예) 김그루", text: $name)
                            .padding()
                            .foregroundColor(Color.BackgroundGray)
                    }
                    .padding(.horizontal, 20)
                
                
                Text("개인 연락처")
                    .padding(.horizontal, 20)
                    
                
                RoundedRectangle(cornerRadius: 7)
                    .frame(height: 45)
                    .foregroundStyle(Color.LightGray2)
                    .overlay(alignment: .leading) {
                        TextField("예) 김그루", text: $name)
                            .padding()
                            .foregroundColor(Color.BackgroundGray)
                    }
                    .padding(.horizontal, 20)
                
                
                Text("사업장 연락처")
                    .padding(.horizontal, 20)
                    
                
                RoundedRectangle(cornerRadius: 7)
                    .frame(height: 45)
                    .foregroundStyle(Color.LightGray2)
                    .overlay(alignment: .leading) {
                        TextField("예) 김그루", text: $name)
                            .padding()
                            .foregroundColor(Color.BackgroundGray)
                    }
                    .padding(.horizontal, 20)
                
                Text("사업자등록증 이미지")
                    .padding(.horizontal, 20)
                    
                
                RoundedRectangle(cornerRadius: 7)
                    .foregroundStyle(Color.clear)
                    .border(Color.black, width: 1)
                    .overlay(alignment: .center) {
                        Text("+ 사진 추가하기")
                    }
                    .padding(.horizontal, 20)
                
                Spacer()
                
                NavigationLink {
                    // Next Page
                    
                } label: {
                    Text("다음")
                        .grewButtonModifier(width: 343, height: 60, buttonColor: .Main, font: .b1_B, fontColor: .white, cornerRadius: 8)
                        .padding()
                }

                
                
                
                
            }
            .navigationTitle(Text("그루터기 멤버 신청").font(.b2_B))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        // alert 띄워주기
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    EnrollGTMemberDetailView()
}
