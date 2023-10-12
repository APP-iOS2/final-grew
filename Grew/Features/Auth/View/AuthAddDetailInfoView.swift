//
//  AuthAddDetailView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//

import SwiftUI

struct AuthAddDetailInfoView: View {
    
    @EnvironmentObject var registerVM: RegisterVM
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading) {
                Text("이름")
                    .font(Font.b2_L)
                TextField("name", text: $registerVM.nickName, axis: .vertical)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                
                Text("생년월일 (8자리)")
                    .font(Font.b2_L)
                TextField("dob", text: $registerVM.dob, axis: .vertical)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                
                Text("성별")
                    .font(Font.b2_L)
                Picker("Gender", selection: $registerVM.gender) {
                    ForEach(Gender.allCases, id: \.self) { gender in
                        Text("\(gender.rawValue)")
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(20)
            Spacer()
        }
    }
}

#Preview {
    AuthAddDetailInfoView()
}
