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
                            RemoveAdsView()
                        } label: {
                            Text("광고 제거")
                            
                        }
                    }.listRowSeparator(.hidden)
                    
                    Section(header: Text("그루터기")){
                        ForEach(GTViewsName.allCases, id: \.self) { gtViewName in
                            
                            NavigationLink {
                                switch gtViewName {
                                case .stumpIntroductionView:
                                    StumpIntroductionView()
                                case .stumpRegisterView:
                                    StumpRegisterView()
                                case .showGTView:
                                    ShowGTView()
                                }
                            } label: {
                                Text(gtViewName.rawValue)
                            }
                            
                        }
                    }.listRowSeparator(.hidden)
                    
                    // TODO: 로그인 연동하기
                    Section(header: Text("계정 설정")){
                        Button {
                            AuthStore.shared.signOut()
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
                        ForEach(InformViewsName.allCases, id:\.self) { informViewName in
                            NavigationLink {
                                switch informViewName {
                                case .opensourceLicenseView:
                                    OpensourceLicenseView()
                                case .developersView:
                                    DevelopersView()
                                case .inquireyView:
                                    InquiryView()
                                }
                            } label: {
                                Text(informViewName.rawValue)
                                
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
    
    enum GTViewsName: String, CaseIterable {
        case stumpIntroductionView = "그루터기 멤버 신청하기"
        case stumpRegisterView = "그루터기 등록하기"
        case showGTView = "그루터기 보기"
        
        static var allCases: [GTViewsName] {
            return [
                .stumpIntroductionView,
                .stumpRegisterView,
                .showGTView,
            ]
        }
    }
    
    enum InformViewsName: String, CaseIterable {
        case opensourceLicenseView = "오픈소스 라이센스"
        case developersView = "개발자 정보"
        case inquireyView = "문의하기"
        
        static var allCases: [InformViewsName] {
            return [
                .opensourceLicenseView,
                .developersView,
                .inquireyView
            ]
        }
    }
}

#Preview {
    SettingView()
}
