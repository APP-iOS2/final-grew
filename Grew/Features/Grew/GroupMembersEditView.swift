//
//  GroupMembersEditView.swift
//  CircleRecruitment
//
//  Created by 윤진영 on 2023/09/21.
//

import SwiftUI

struct GroupMembersEditView: View {
    @EnvironmentObject var viewModel: GrewViewModel
    @State private var isShowingAlert = false
    @State private var isNavigatingToNextView = false
    @State private var isAnimating = false
    @Binding var isMaximumMembersValid: Bool
    
    @State private var isWrongname: Bool = false
    @State private var isWrongdob: Bool = false
    @State private var isMeetingTextfieldDisabled: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("어떤 멤버를 모집할까요?")
                    .font(.b1_R).fontWeight(.semibold)
                    .padding(.bottom, 10)
                HStack(spacing: 15) {
                    Text("성별")
                    Picker("Gender", selection: $viewModel.gender) {
                        ForEach(Gender.allCases, id: \.self) { gender in
                            Text(gender.rawValue)
                        }
                    }.pickerStyle(.segmented)
                }
                HStack(spacing: 15) {
                    Text("나이")
                    Picker("minimumAge", selection: $viewModel.minimumAge) {
                        ForEach(20..<61, id: \.self) { minimumAge in
                            Text("\(minimumAge)세")
                        }
                    }.pickerStyle(.wheel)
                    Text("~")
                    Picker("maximumAge", selection: $viewModel.maximumAge) {
                        ForEach(viewModel.minimumAge..<101, id: \.self) { maximumAge in
                            Text("\(maximumAge)세")
                        }
                    }.pickerStyle(.wheel)
                    Spacer()
                }
                .frame(height: 120)
            }
            .padding()
            .animationModifier(isAnimating: isAnimating, delay: 0)
            VStack(alignment: .leading) {
                Text("최대 인원을 입력해주세요")
                    .font(.b1_R).fontWeight(.semibold)
                    .padding(.bottom, 10)
                VStack(alignment: .leading) {
                    
                    GrewTextField(text: $viewModel.maximumMembers, isWrongText: isWrongname, isTextfieldDisabled: isMeetingTextfieldDisabled, placeholderText: "최대 인원을 입력해주세요", isSearchBar: false)
                        .onChange(of: viewModel.maximumMembers) { oldValue, newValue in
                            if let numer = Int(newValue) {
                                if numer > 200 {
                                    viewModel.maximumMembers = "200"
                                }
                            } else {
                                viewModel.maximumMembers = ""
                            }
                            isMaximumMembersValid = !newValue.isEmpty
                        }
                        .keyboardType(.numberPad)
                }
            }
            .padding()
            .animationModifier(isAnimating: isAnimating, delay: 1)
        }//: ScrollView
        .scrollDismissesKeyboard(.immediately)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onAppear(perform: {
            isAnimating = true
            if !isMaximumMembersValid {
                viewModel.maximumMembers = ""
            }
        })
    }//: body
}

#Preview {
    GroupMembersEditView(isMaximumMembersValid: .constant(true))
        .environmentObject(GrewViewModel())
}
