//
//  AuthAddDetailView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//

import SwiftUI

struct AuthAddDetailInfoView: View {
    
    @Binding var isButton3: Bool
    @EnvironmentObject var viewModel: RegisterViewModel
    @State private var isWrongname: Bool = false
    @State private var isWrongdob: Bool = false
    @State private var isNameTextfieldDisabled: Bool = false
    @State private var isTextfieldDisabled: Bool = false
    private var writeAllTextField: Bool {
        if isWrongname || isWrongdob || viewModel.dob.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading) {
                Text("이름")
                    .font(Font.b2_L)
                GrewTextField(text: $viewModel.nickName, isWrongText: isWrongname, isTextfieldDisabled: isNameTextfieldDisabled, placeholderText: "이름", isSearchBar: false)
//                    .onChange(of: viewModel.nickName) {
//                        isWrongname = !(viewModel.isValiddob(viewModel.nickName))
//                    }
                
                Text("생년월일 (8자리)")
                    .font(Font.b2_L)
                GrewTextField(text: $viewModel.dob, isWrongText: isWrongdob, isTextfieldDisabled: isTextfieldDisabled, placeholderText: "생년월일", isSearchBar: false)
                    .onChange(of: viewModel.dob) {
                        isWrongdob = !(viewModel.isValiddob(viewModel.dob))
                    }
                
                Text("성별")
                    .font(Font.b2_L)
                Picker("Gender", selection: $viewModel.gender) {
                    ForEach(Gender.allCases, id: \.self) { gender in
                        Text("\(gender.rawValue)")
                    }
                }
                .pickerStyle(.segmented)
            }
            .onChange(of: writeAllTextField) {
                isButton3 = writeAllTextField ? true : false
            }
            .onAppear {
                if UserDefaults.standard.string(forKey: "SignType") != "email" {
                    isNameTextfieldDisabled = true
                }
            }
            .padding(20)
            Spacer()
        }
    }
}

#Preview {
    AuthAddDetailInfoView(isButton3: .constant(true))
        .environmentObject(RegisterViewModel())
}
