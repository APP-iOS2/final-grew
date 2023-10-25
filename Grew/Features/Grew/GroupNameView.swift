//
//  GroupNameView.swift
//  CircleRecruitment
//
//  Created by 윤진영 on 2023/09/22.
//

import SwiftUI

struct GroupNameView: View {
    @EnvironmentObject var viewModel: GrewViewModel
    @State private var isNextView = false
    @State private var isAnimating = false
    @State private var groupNameView = false
    @Binding var isNameValid: Bool
    @Binding var isLocationValid: Bool
    @State var isShowingSheet = false
    
    @State private var isWrongname: Bool = false
    @State private var isWrongdob: Bool = false
    @State private var isMeetingTextfieldDisabled: Bool = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("모임이름을 입력해주세요")
                    .font(.b1_R).fontWeight(.semibold)
                    .padding(.bottom, 10)
                VStack(alignment: .leading) {
                    GrewTextField(text: $viewModel.meetingTitle, isWrongText: isWrongname, isTextfieldDisabled: isMeetingTextfieldDisabled, placeholderText: "모임이름을 입력해주세요", isSearchBar: false)
                        .onChange(of: viewModel.meetingTitle){ oldValue, newValue in
                            isNameValid = !newValue.isEmpty
                        }
                }
            }
            .padding()
            .animationModifier(isAnimating: isAnimating, delay: 0)
            
            VStack(alignment: .leading) {
                Text("활동방법을 선택해주세요")
                    .font(.b1_R).fontWeight(.semibold)
                    .padding(.bottom, 0)
                HStack(spacing: 40) {
                    Spacer()
                    Button {
                        viewModel.isOnline = true
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    } label: {
                        Text("온라인")
                            .grewButtonModifier(width: 90, height: 50, buttonColor: viewModel.isOnline ? Color.Sub : Color.BackgroundGray, font: .b2_B, fontColor: .white, cornerRadius: 10)
                    }
                    
                    
                    Button(action: {
                        viewModel.isOnline = false
                        isNextView = true
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }, label: {
                        Text("오프라인")
                            .grewButtonModifier(width: 90, height: 50, buttonColor: viewModel.isOnline ? Color.BackgroundGray : Color.Sub, font: .b2_B, fontColor: .white, cornerRadius: 10)
                    })
                    Spacer()
                    
                }
                
            }
            .padding()
            .animationModifier(isAnimating: isAnimating, delay: 1)
            
            if !viewModel.isOnline {
                VStack(alignment: .leading) {
                    Divider()
                    HStack {
                        Image(systemName: "location.circle.fill")
                        Text("장소")
                    }
                    Button {
                        isShowingSheet = true
                    } label: {
                        if viewModel.location.isEmpty {
                            Image(systemName: "magnifyingglass")
                            Text("장소를 입력해주세요")
                        } else {
                            Text(viewModel.location)
                        }
                    }.grewButtonModifier(width: 343, height: 40, buttonColor: .LightGray1, font: .b3_R, fontColor: .black, cornerRadius: 10)
                        .onChange(of: viewModel.location) { _, newValue in
                            isLocationValid = !newValue.isEmpty
                        }
                }.padding()
                    .animationModifier(isAnimating: groupNameView, delay: 0)
                    .onAppear {
                        groupNameView = true
                    }
            }
            
        }
        .scrollDismissesKeyboard(.immediately)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .sheet(isPresented: $isShowingSheet, content: {
            ZStack{
                WebView(
                    request: URLRequest(url: URL(string: "https://da-hye0.github.io/Kakao-Postcode/")!),
                    showingWebSheet: $isShowingSheet,
                    location: $viewModel.location, latitude: $viewModel.latitude,
                    longitude: $viewModel.longitude
                )
                .padding(.top, 25)
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        })
        .onAppear(perform: {
            isAnimating = true
            
            if !isNameValid {
                viewModel.meetingTitle = ""
                viewModel.location = ""
            }
        })
    }
}

#Preview {
    GroupNameView(isNameValid: .constant(true), isLocationValid: .constant(true))
        .environmentObject(GrewViewModel())
}
