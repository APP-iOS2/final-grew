//
//  GroupNameView.swift
//  CircleRecruitment
//
//  Created by 윤진영 on 2023/09/22.
//

import SwiftUI

struct GroupNameView: View {
    @EnvironmentObject var viewModel: GrewViewModel
    @State private var isNextView = false
    @State private var isAnimating = false
    @State private var groupNameView = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("모임이름을 적어볼까요?")
                    .font(.title2).fontWeight(.semibold)
                    .padding(.bottom, 10)
                
                HStack(spacing: 15) {
                    TextField("모임이름을 입력해주세요", text: $viewModel.meetingTitle)
                        .keyboardType(.namePhonePad)
                }
                .padding(10)
                .overlay{
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 2)
                }
                .cornerRadius(5)
            }//: VStack
            .padding()
            .animationModifier(isAnimating: isAnimating, delay: 0)
            
            VStack(alignment: .leading) {
                Text("주로 어디에서 활동하세요?")
                    .font(.title2).fontWeight(.semibold)
                    .padding(.bottom, 0)
                HStack(spacing: 40) {
                    Spacer()
                    Button(action: { 
                        viewModel.isOnline = true
                    }, label: {
                        Text("온라인")
                            .grewButtonModifier(width: 100, height: 50, buttonColor: viewModel.isOnline ? Color.Sub : Color.BackgroundGray, font: .b1_B, fontColor: .white, cornerRadius: 10)
                    })
                    
                    Button(action: {
                        viewModel.isOnline = false
                        isNextView = true
                    }, label: {
                        Text("오프라인")
                            .grewButtonModifier(width: 100, height: 50, buttonColor: viewModel.isOnline ? Color.BackgroundGray : Color.Sub, font: .b1_B, fontColor: .white, cornerRadius: 10)
                    })
                    Spacer()
                }//: HStack
            }//: VStack
            .padding()
            .animationModifier(isAnimating: isAnimating, delay: 1)
            
            if !viewModel.isOnline {
                VStack(alignment: .leading) {
                    Divider()
                    HStack {
                        Image(systemName: "location.circle.fill")
                        Text("장소")
                    }
                    TextField("장소를 입력하세요", text: $viewModel.location)
                        .padding(10)
                        .overlay{
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 2)
                        }
                        .cornerRadius(5)
                }.padding()
                .animationModifier(isAnimating: groupNameView, delay: 0)
                .onAppear {
                    groupNameView = true
                }
            }
            
        }//: ScrollView
        .onAppear(perform: {
            isAnimating = true
        })
    }//: body
}

#Preview {
    GroupNameView()
        .environmentObject(GrewViewModel())
}
