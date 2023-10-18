//
//  NewGrewView.swift
//  CircleRecruitment
//
//  Created by KangHo Kim on 2023/09/21.
//

import SwiftUI

struct NewGrewView: View {
    @EnvironmentObject var viewModel: GrewViewModel
    @State private var currentViewIndex: Int = 1
    @State private var progressBarValue: Double = 0
    @State private var progressBarTotal: Double = 100
    @Environment (\.dismiss) var dismiss
    @State var isNameValid = false
    @State var isMaximumMembersValid = false
    @State var isFeeValid = false
    @State var isCategoryValid = false
    @State var isLocationValid = false
    @State var isNeedFeeValid = false
    
    var body: some View {
        NavigationStack {
            if currentViewIndex != 5 {
                VStack(alignment: .center) {
                    Text("그루 생성")
                        .font(.h1_B)
                        .foregroundStyle(Color.DarkGray2)
                    ProgressView(value: progressBarValue, total: progressBarTotal)
                        .progressViewStyle(GrewProgressViewStyle(
                            value: $progressBarValue,
                            total: $progressBarTotal))
                        .frame(height: 50)
                    
                }//: VStack
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if currentViewIndex != 5 && currentViewIndex != 1{
                            Button {
                                if currentViewIndex != 1 {
                                    currentViewIndex -= 1
                                }
                            } label: {
                                Image(systemName: "chevron.backward")
                                    .font(.system(size: 32))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if currentViewIndex != 5 {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 32))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }//: toolbar
            }
            ZStack {
                newGrewView
            }
        }//: NavigationStack
    }
}

extension NewGrewView {
    
    var newGrewView: some View {
        VStack {
            if currentViewIndex == 1 {
                GroupMainCategoryView(isCategoryValid: $isCategoryValid)
                    .onAppear(perform: {
                        progressBarValue = (100 / 5) * 1
                    })
            } else if currentViewIndex == 2 {
                GroupNameView(isNameValid: $isNameValid, isLocationValid: $isLocationValid)
                    .onAppear(perform: {
                        progressBarValue = (100 / 5) * 2
                    })
            } else if currentViewIndex == 3 {
                GroupMembersEditView(isMaximumMembersValid: $isMaximumMembersValid)
                    .onAppear(perform: {
                        progressBarValue = (100 / 5) * 3
                    })
            } else if currentViewIndex == 4 {
                GroupCheckFeeView(isFeeValid: $isFeeValid, isNeedFeeValid: $isNeedFeeValid)
                    .onAppear(perform: {
                        progressBarValue = (100 / 5) * 4
                    })
            } else if currentViewIndex == 5 {
                GroupAlertView()
                    .onAppear(perform: {
                        progressBarValue = (100 / 5) * 5
                    })
            }
            
            if currentViewIndex < 5 {
                Button {
                    currentViewIndex += 1
                    if currentViewIndex == 1 && isCategoryValid {
                        currentViewIndex += 1
                    } else if currentViewIndex == 2 && (isNameValid || !viewModel.isOnline) && isLocationValid {
                        currentViewIndex += 1
                    } else if currentViewIndex == 3 && isMaximumMembersValid {
                        currentViewIndex += 1
                    } else if currentViewIndex == 4 && (isFeeValid || !viewModel.isNeedFee) && isFeeValid {
                        currentViewIndex += 1
                    }
                    
                    if currentViewIndex == 5 {
                        let grew = Grew(
                            categoryIndex: viewModel.selectedCategoryId,
                            categorysubIndex: viewModel.selectedSubCategoryId,
                            title: viewModel.meetingTitle,
                            description: "",
                            isOnline: viewModel.isOnline,
                            location: viewModel.isOnline ? "" : viewModel.location,
                            gender: viewModel.gender,
                            minimumAge: viewModel.minimumAge,
                            maximumAge: viewModel.maximumAge,
                            maximumMembers: Int(viewModel.maximumMembers) ?? 0,
                            isNeedFee: viewModel.fee.isEmpty ? false : true,
                            fee: Int(viewModel.fee) ?? 0)
                        viewModel.addGrew(grew)
                        print("\(grew)")
                    }
                } label: {
                    Text("다음")
                        .grewButtonModifier(
                            width: 343,
                            height: 60,
                            buttonColor:
                                currentViewIndex == 1 && !isCategoryValid ||
                            currentViewIndex == 2 && ((!isNameValid && viewModel.isOnline) || (!viewModel.isOnline && !isLocationValid)) ||
                            currentViewIndex == 3 && !isMaximumMembersValid && !isFeeValid ||
                            currentViewIndex == 4 && ((!isFeeValid && viewModel.isNeedFee) || (!viewModel.isNeedFee && isNeedFeeValid)) ? .LightGray2 : .Main,
                            font: .b1_B, fontColor: .white, cornerRadius: 8)
                }.disabled(
                    currentViewIndex == 1 && !isCategoryValid ||
                    currentViewIndex == 2 && !isNameValid ||
                    currentViewIndex == 3 && !isMaximumMembersValid ||
                    currentViewIndex == 4 && !isFeeValid && viewModel.isNeedFee)
            }
        }
    }
}



#Preview {
    NewGrewView()
        .environmentObject(GrewViewModel())
}
