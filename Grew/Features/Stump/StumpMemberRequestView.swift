//
//  StumpMemberRequestView.swift
//  Grew
//
//  Created by 김효석 on 10/18/23.
//

import SwiftUI

struct StumpMemberRequestView: View {
    
    @Binding var isShowingRequestSheet: Bool
    @State private var name: String = ""
    @State private var businessNumber: String = ""
    @State private var phoneNumber: String = ""
    @State private var image: UIImage? = nil
    
    @State private var isShowingSelectionSheet: Bool = false
    @State private var isShowingCamera: Bool = false
    @State private var isShowingPhotoLibrary: Bool = false
    @State private var isShowingFinishAlert: Bool = false
    
    var isBusinessNumberCorrect: Bool {
        if businessNumber.isEmpty {
            return true
        }
        let pattern = "^\\d{3}-\\d{2}-\\d{5}$"
            let regex = try? NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: businessNumber.utf16.count)
        return regex?.firstMatch(in: businessNumber, options: [], range: range) != nil
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                makeInputView()
            }
            VStack {
                makeFinishButton()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("그루터기 멤버 신청")
                        .font(.b1_B)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingRequestSheet = false
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color.Black)
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingSelectionSheet) {
            ImageEditModalView(showModal: $isShowingSelectionSheet) { form in
                switch form {
                case .camera:
                    isShowingSelectionSheet = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isShowingCamera = true
                    }
                case .picker:
                    isShowingSelectionSheet = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isShowingPhotoLibrary = true
                    }
                }
            }
            .presentationDetents([.height(120), .height(120)])
        }
        .sheet(isPresented: $isShowingPhotoLibrary, content: {
            ImagePicker(image: $image)
        })
        .sheet(isPresented: $isShowingCamera, content: {
            CameraView(isPresented: $isShowingCamera) { uiImage in
                image = uiImage
            }
        })
        .grewAlert(
            isPresented: $isShowingFinishAlert,
            title: "그루터기 멤버 신청이 완료되었습니다!",
            buttonTitle: "확인",
            buttonColor: .Main
        ) {
            }
    }
    
    private func makeInputView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("그루터기장 이름(사업자 이름)")
                .font(.b2_R)
            GrewTextField(text: $name, isWrongText: false, isTextfieldDisabled: false, placeholderText: "이름", isSearchBar: false)
                .padding(.bottom, 18)
            
            Text("사업자 등록 번호")
                .font(.b2_R)
            GrewTextField(text: $businessNumber, isWrongText: !isBusinessNumberCorrect, isTextfieldDisabled: false, placeholderText: "000-00-0000", isSearchBar: false)
                .padding(.bottom, isBusinessNumberCorrect ? 18 : 0)
                
            if !isBusinessNumberCorrect {
                HStack {
                    Spacer()
                    Text("양식에 맞게 입력해주세요.")
                        .font(.c2_L)
                        .foregroundStyle(Color.Error)
                }
            }
            
            Text("개인 전화번호")
                .font(.b2_R)
            GrewTextField(text: $phoneNumber, isWrongText: false, isTextfieldDisabled: false, placeholderText: "전화번호", isSearchBar: false)
                .padding(.bottom, 18)
            
            Text("사업자 등록 이미지")
                .font(.b2_R)
            Button {
                isShowingSelectionSheet = true
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("사진 추가하기")
                }
                .font(.b1_B)
                .foregroundStyle(Color.DarkGray1)
                .frame(width: 343, height: 142)
            }
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.Black)
            )

            
        }
        .padding(.horizontal, 16)
    }
    
    private func makeFinishButton() -> some View {
        Button {
            isShowingFinishAlert = true
        } label: {
            Text("신청 완료")
        }
        .grewButtonModifier(width: 343, height: 50, buttonColor: .Main, font: .b1_B, fontColor: .white, cornerRadius: 8)
        .padding(.bottom)
        .disabled(
            name.isEmpty || businessNumber.isEmpty || !isBusinessNumberCorrect || phoneNumber.isEmpty
        )
    }
}

#Preview {
    NavigationStack {
        StumpMemberRequestView(isShowingRequestSheet: .constant(true))
    }
}
