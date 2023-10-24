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
    @Binding var isFeeValid: Bool
    @Binding var isNeedFeeValid: Bool
    @State private var isWrongText: Bool = false
    @State private var isTextfieldDisabled: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 4) {
                Text("활동비가 있나요?")
                    .font(.b1_R).fontWeight(.semibold)
                    .padding(.bottom, 10)
                HStack(spacing: 40) {
                    Spacer()
                    // 있으면 금액 입력
                    Button {
                        viewModel.isNeedFee = true
                    } label: {
                        Text("있음")
                            .grewButtonModifier(width: 90, height: 50, buttonColor: viewModel.isNeedFee ? Color.Sub : Color.BackgroundGray, font: .b2_B, fontColor: .white, cornerRadius: 10)
                    }
                    Button(action: {
                        viewModel.isNeedFee = false
                        isAnimatingFeeView = false
                    }, label: {
                        Text("없음")
                            .grewButtonModifier(width: 90, height: 50, buttonColor: viewModel.isNeedFee ? Color.BackgroundGray : Color.Sub, font: .b2_B, fontColor: .white, cornerRadius: 10)
                    })
                    Spacer()
                }
            }
            .padding()
            .animationModifier(isAnimating: isAnimating, delay: 0)
            if viewModel.isNeedFee {
                VStack(alignment: .leading) {
                    Divider()
                    HStack {
                        Image(systemName: "dollarsign.circle.fill")
                        Text("활동비")
                    }
                    VStack(alignment: .leading) {
                        GrewTextField(text: $viewModel.fee, isWrongText: isWrongText, isTextfieldDisabled: isTextfieldDisabled, placeholderText: "활동비를 입력해주세요", isSearchBar: false)
                            .onChange(of: viewModel.fee) { oldValue, newValue in
                                if Int(newValue) != nil {
                                    
                                } else {
                                    viewModel.fee = ""
                                }
                                isFeeValid = !newValue.isEmpty
                            }
                    }
                }
                .padding()
                .animationModifier(isAnimating: isAnimatingFeeView, delay: 0)
                .onAppear {
                    isAnimatingFeeView = true
                    if !isFeeValid {
                        viewModel.fee = ""
                    }
                }
            }
        }//: ScrollView
        .scrollDismissesKeyboard(.immediately)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onAppear(perform: {
            isAnimating = true
        })
    }//: body
}

#Preview {
    GroupCheckFeeView(isFeeValid: .constant(true), isNeedFeeValid: .constant(true))
        .environmentObject(GrewViewModel())
}
