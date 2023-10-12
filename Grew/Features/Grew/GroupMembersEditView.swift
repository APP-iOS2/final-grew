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
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("어떤 멤버를 모집할까요?")
                    .font(.title2).fontWeight(.semibold)
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
                Text("최대 몇 명과 함께 할까요?")
                    .font(.title2).fontWeight(.semibold)
                    .padding(.bottom, 10)
                HStack(spacing: 15) {
                    TextField("최대 몇 명과 함께 할까요?", text: $viewModel.maximumMembers)
                        .onChange(of: viewModel.maximumMembers) { oldValue, newValue in
                            if let numer = Int(newValue) {
                                if numer > 200 {
                                    viewModel.maximumMembers = "200"
                                }
                            } else {
                                viewModel.maximumMembers = ""
                            }
                        }
                        .keyboardType(.numberPad)
                    
                    HStack {
                        Text("\(viewModel.maximumMembers)/200")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.trailing)
                            .padding(.top, 4)
                    }
                }
                .padding(10)
                .overlay{
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 2)
                }
                .cornerRadius(5)
            }
            .padding()
            .animationModifier(isAnimating: isAnimating, delay: 1)
        }//: ScrollView
        .onAppear(perform: {
            isAnimating = true
        })
    }//: body
}

#Preview {
    GroupMembersEditView()
        .environmentObject(GrewViewModel())
}
