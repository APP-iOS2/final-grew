//
//  SettingView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/09/25.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var isAlertOn: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section(header: Text("앱 설정")){
                        Toggle(isOn: $isAlertOn, label: {
                            Text("푸시 알림")
                                .listRowSeparator(.visible)
                        })
                        
                        NavigationLink {
                            
                        } label: {
                            Text("광고 제거")
                            
                        }
                    }.listRowSeparator(.hidden)
                    
                    // TODO: 로그인 연동하기
                    Section(header: Text("계정 설정")){
                        Button {
                            AuthStore.shared.emailAuthSignOut()
                        } label: {
                            HStack {
                                Text("로그아웃")
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                        }

                        NavigationLink {
                            
                        } label: {
                            Text("회원 탈퇴")
                                .foregroundStyle(.red)
                        }
                        
                        
                    }.listRowSeparator(.hidden)
                    
                    
                    Section(header: Text("안내")) {
                        ForEach(appInfo) { index in
                            NavigationLink {
                                Text("\(index.name)")
                            } label: {
                                Text("\(index.name)")
                                
                            }.listRowSeparator(.hidden)
                        }
                    }
                    
                }
                .listStyle(.plain)
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.mode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.black)
            }))
        }
        
    }
}

#Preview {
    SettingView()
}
