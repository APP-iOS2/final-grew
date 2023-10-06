//
//  SettingView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/09/25.
//

import SwiftUI

struct SettingView: View {
    
    
    var body: some View {
        NavigationStack {
                Section(header: Text("설정")) {
                    List {
                        Section(header: Text("안내")) {
                            ForEach(intros) { intro in
                                NavigationLink {
                                    Text("\(intro.name)")
                                } label: {
                                    Text("\(intro.name)")
                                }

                            }
                        }
                        
                        Section(header: Text("사용자 설정")){
                            NavigationLink {
                                
                            } label: {
                                Text("알림 설정")
                            }
                        }
                        
                        // TODO: 로그인 연동하기
                        Section(header: Text("계정")){
                            Text("계정 관리")
                            Text("로그아웃")
                        }
                        
                        NavigationLink {
                            
                        } label: {
                            Text("오픈소스 라이센스")
                        }
                        
                            Text("앱 버전")
                        
                    }
                    .listStyle(.grouped)
                }
            }
        }
    }

#Preview {
    SettingView()
}
