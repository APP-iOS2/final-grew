////
////  AuthCompleteView.swift
////  Grew
////
////  Created by 김종찬 on 10/5/23.
////
//
// import SwiftUI
//
// struct AuthCompleteView: View {
//
//    @Environment(\.dismiss) var dismiss
//    @EnvironmentObject var authStore: AuthStore
//    @EnvironmentObject var userStore: UserStore
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Text("Complete")
//                    .font(.headline)
//                
//                Text(userStore.user?.nickName ?? "")
////                Text(userStore.user!.email)
////                Text(userStore.user!.gender.rawValue)
////                Text(userStore.user!.dob)
//                
//                NavigationLink {
//                    AuthSignEmailView()
//                } label: {
//                    Text("Logout")
//                }
//                .simultaneousGesture(TapGesture().onEnded{
//                    switch authStore.signState {
//                    case .email:
//                        authStore.emailAuthSignOut()
////                    case .facebook:
////                        authStore.facebookSignOut()
////                    case .kakao:
////                        authStore.kakaoSignOut()
//                    case .signOut:
//                        return
//                    }
//                    dismiss()
//                })
//            }
//        }
//    }
// }
//
// #Preview {
//    AuthCompleteView()
//        .environmentObject(AuthStore())
// }
