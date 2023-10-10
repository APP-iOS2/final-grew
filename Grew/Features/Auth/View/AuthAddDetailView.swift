//
//  AuthAddDetailView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//

import SwiftUI

struct AuthAddDetailView: View {
    
    @EnvironmentObject var authStore: AuthStore
    @EnvironmentObject var userStore: UserStore
    @State private var gender: Gender = .female
    
    var body: some View {
        NavigationStack {
            
            Text("이름을 입력하세요")
            TextField("name", text: $authStore.nickName, axis: .vertical)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
            
            Text("생년월일을 입력하세요")
            TextField("dob", text: $authStore.dob, axis: .vertical)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
            
            Text("성별을 선택하세요")
            Picker("Gender", selection: $gender) {
                ForEach(Gender.allCases, id: \.self) { gender in
                    Text("\(gender.rawValue)")
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            Button {
                authStore.gender = gender.rawValue
                Task {
                    try await authStore.emailAuthSignUp()
                }
            } label: {
                Text("완료")
            }
        }
    }
}

#Preview {
    AuthAddDetailView()
        .environmentObject(AuthStore())
}
