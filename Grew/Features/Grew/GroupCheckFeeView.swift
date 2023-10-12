//
//  GroupCheckFeeView.swift
//  CircleRecruitment
//
//  Created by 윤진영 on 2023/09/21.
//

import SwiftUI

struct GroupCheckFeeView: View {
    @EnvironmentObject var viewModel: GrewViewModel
    @State private var showsAlert = false
    @State private var isAnimating = false
    @State private var isAnimatingFeeView = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 4) {
                Text("활동비가 있나요?")
                    .font(.title2).fontWeight(.semibold)
                    .padding(.bottom, 10)
                
                HStack(spacing: 40) {
                    Spacer()
                    // 있으면 금액 입력
                    Button(action: {
                        viewModel.isNeedFee = true
                    }, label: {
                        Text("있음")
                            .font(.title2.bold())
                            .frame(width: 100, height: 50)
                            .foregroundColor(.white)
                            .background(viewModel.isNeedFee ? Color.green : Color.gray)
                            .cornerRadius(10)
                    })
                    Button(action: {
                        viewModel.isNeedFee = false
                        isAnimatingFeeView = false
                    }, label: {
                        Text("없음")
                            .font(.title2.bold())
                            .frame(width: 100, height: 50)
                            .foregroundColor(.white)
                            .background(viewModel.isNeedFee ? Color.gray : Color.green)
                            .cornerRadius(10)
                    })
                    Spacer()
                }
            }
            .padding()
            .animationModifier(isAnimating: isAnimating, delay: 0)
            if viewModel.isNeedFee {
                VStack(alignment: .leading) {
                    Divider()
                        .padding(.bottom, 20)
                    HStack {
                        Image(systemName: "dollarsign.circle.fill")
                        Text("활동비")
                    }
                    TextField("활동비를 입력하세요", text: $viewModel.fee)
                        .onChange(of: viewModel.fee) { oldValue, newValue in
                            if Int(newValue) != nil {
                                
                            } else {
                                viewModel.fee = ""
                            }
                        }
                        .keyboardType(.numberPad)
                        .padding(10)
                        .overlay{
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 2)
                        }
                        .cornerRadius(5)
                        .keyboardType(.numberPad)
                }
                .padding()
                .animationModifier(isAnimating: isAnimatingFeeView, delay: 0)
                .onAppear {
                    isAnimatingFeeView = true
                }
            }
        }//: ScrollView
        .onAppear(perform: {
            isAnimating = true
        })
    }//: body
}

#Preview {
    GroupCheckFeeView()
        .environmentObject(GrewViewModel())
}
