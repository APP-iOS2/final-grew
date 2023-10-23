//
//  GrewEditSheetView.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/22.
//

import SwiftUI

struct GrewEditSheetView: View {
    @EnvironmentObject var grewViewModel: GrewViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @Binding var isShowingWithdrawConfirmAlert: Bool
    @Binding var isShowingToolBarSheet: Bool
    
    
    let grew: Grew
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0, green: 0, blue: 0, opacity: 0.3)
                VStack {
                    Spacer()
                    if grew.hostID == UserStore.shared.currentUser?.id ?? "" {
                        NavigationLink(destination: {
                            GrewEditView()
                        }, label: {
                            HStack {
                                Text("그루 수정")
                                Spacer()
                                Image(systemName: "pencil")
                            }
                        })
                        .padding(.vertical, 8)
                        .foregroundStyle(Color.Black)
                        Divider()
                        Button {
                            //
                        } label: {
                            Text("그루트 관리")
                            Spacer()
                            Image(systemName: "pencil")
                        }
                        .padding(.vertical, 8)
                        .foregroundStyle(Color.Black)
                        Divider()
                        Button {
                            //
                        } label: {
                            Text("그루 해체하기")
                            Spacer()
                            Image(systemName: "trash")
                        }
                        .padding(.vertical, 8)
                        .foregroundStyle(Color.Error)
                    } else {
                        HStack {
                            Button {
                                //
                            } label: {
                                Text("탈퇴하기")
                                Spacer()
                                Image(systemName: "trash")
                            }
                            .padding(.vertical, 8)
                            .foregroundStyle(Color.Error)
                        }
                        Image(systemName: "pencil")
                            .padding(.vertical, 8)
                            .foregroundStyle(Color.Black)
                        Divider()
                        Button {
                            //
                        } label: {
                            Text("그루 해체하기")
                            Spacer()
                            Image(systemName: "trash")
                        }
                        .padding(.vertical, 8)
                        .foregroundStyle(Color.Error)
                    }
                }
                .font(.b2_R)
                .padding(20)
            }
        }
        .ignoresSafeArea(.all)
        .onAppear(perform: {
            userViewModel.fetchUser(userId: UserStore.shared.currentUser?.id ?? "")
        })
    }
}

#Preview {
    GrewEditSheetView(isShowingWithdrawConfirmAlert: .constant(false), isShowingToolBarSheet: .constant(true), grew: Grew(
        id: "id",
        categoryIndex: "게임/오락",
        categorysubIndex: "보드게임",
        title: "멋쟁이 보드게임",
        description: "안녕하세요!\n보드게임을 잘 해야 한다 ❌\n보드게임을 좋아한다 🅾️ \n\n즐겁게 보드게임을 함께 할 친구들이 필요하다면,\n<멋쟁이 보드게임> 그루에 참여하세요!\n\n매주 수요일마다 모이는 정기 모임과\n자유롭게 모이는 번개 모임을 통해\n많은 즐거운 추억을 쌓을 수 있어요 ☺️\n\n",
        imageURL: "https://images.unsplash.com/photo-1696757020926-d627b01c41cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=900&q=60",
        isOnline: false,
        location: "서울",
        gender: .any,
        minimumAge: 20,
        maximumAge: 40,
        maximumMembers: 8,
        currentMembers: ["id1", "id2"],
        isNeedFee: false,
        fee: 0
    )
    )
    .environmentObject(UserViewModel())
}
