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
                GroupMainCategoryView()
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
                            .grewButtonModifier(width: 343, height: 60, buttonColor: .Main, font: .b1_B, fontColor: .white, cornerRadius: 8)
                }
            }
        }
    }
}


#Preview {
    NewGrewView()
        .environmentObject(GrewViewModel())
}
