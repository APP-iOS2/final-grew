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
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                ProgressView(value: progressBarValue, total: progressBarTotal)
                    .progressViewStyle(GrewProgressViewStyle(
                        value: $progressBarValue,
                        total: $progressBarTotal))
                    .frame(height: 50)
                HStack {
                    Button {
                        if currentViewIndex != 1 {
                            currentViewIndex -= 1
                        } else if currentViewIndex == 1 {
                            dismiss()
                        }
                    } label: {
                        if currentViewIndex == 1 {
                            Image(systemName: "xmark")
                                .font(.system(size: 32))
                                .foregroundColor(.gray)
                        } else if currentViewIndex != 5 {
                            Image(systemName: "chevron.backward")
                                .font(.system(size: 32))
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                }//: HStack
                .padding(.horizontal)
            }//: VStack
            ZStack {
                VStack {
                    if currentViewIndex == 1 {
                        GroupCategoryView()
                            .onAppear(perform: {
                                progressBarValue = (100 / 5) * 1
                            })
                    } else if currentViewIndex == 2 {
                        GroupNameView()
                            .onAppear(perform: {
                                progressBarValue = (100 / 5) * 2
                            })
                    } else if currentViewIndex == 3 {
                        GroupMembersEditView()
                            .onAppear(perform: {
                                progressBarValue = (100 / 5) * 3
                            })
                    } else if currentViewIndex == 4 {
                        GroupCheckFeeView()
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
                            if currentViewIndex == 5 {
                                let grew = Grew(categoryIndex: viewModel.selectedCategoryId,
                                categorysubIndex: viewModel.selectedSubCategoryId,
                                title: viewModel.meetingTitle,
                                description: "",
                                isOnline: viewModel.isOnline,
                                location: viewModel.isOnline ? "" : "Address",
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
                                .grewButtonModifier(width: 343, height: 44, buttonColor: .Main, font: .b1_B)
                                .padding(.horizontal)
                        }//: Button
                    }
                }//: VStack
            }//: ZStack
        }//: VStack
    }//: body
}

#Preview {
    NewGrewView()
        .environmentObject(GrewViewModel())
}
