//
//  StumpMemberRequestView.swift
//  Grew
//
//  Created by 김효석 on 10/18/23.
//

import SwiftUI

struct StumpMemberRequestView: View {
    
    @EnvironmentObject private var stumpStore: StumpStore
    
    @Binding var isShowingRequestSheet: Bool
    @State private var name: String = ""
    @State private var businessNumber: String = ""
    @State private var phoneNumber: String = ""
    @State private var image: UIImage? = nil
    
    @State private var isShowingSelectionSheet: Bool = false
    @State private var isShowingCamera: Bool = false
    @State private var isShowingPhotoLibrary: Bool = false
    @State private var isShowingSuccessAlert: Bool = false
    @State private var isShowingFailureAlert: Bool = false
    @State private var isLoading = false
    
    private var isFinishButtonDisabled: Bool {
        name.isEmpty ||
        businessNumber.isEmpty ||
        !isBusinessNumberValid ||
        phoneNumber.isEmpty ||
        image == nil
    }
    
    private var isBusinessNumberValid: Bool {
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
                makeImageView()
            }
            VStack {
                makeFinishButton()
            }
            .navigationTitle("그루터기 멤버 신청")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
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
        .overlay(
            Group {
                if isLoading {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(2)
                        .frame(
                            width: UIScreen.screenWidth,
                            height: UIScreen.screenHeight
                        )
                }
            }
        )
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
        .sheet(isPresented: $isShowingPhotoLibrary) { ImagePicker(image: $image)
        }
        .sheet(isPresented: $isShowingCamera) {
            CameraView(isPresented: $isShowingCamera) { uiImage in
                image = uiImage
            }
        }
        .grewAlert(
            isPresented: $isShowingSuccessAlert,
            title: "그루터기 멤버 신청이 완료되었습니다!",
            secondButtonTitle: nil,
            secondButtonColor: nil,
            secondButtonAction: nil,
            buttonTitle: "확인",
            buttonColor: .Main
        ) {
            isShowingRequestSheet = false
        }
        .grewAlert(
            isPresented: $isShowingFailureAlert,
            title: "그루터기 멤버 신청에 실패했습니다.",
            secondButtonTitle: nil,
            secondButtonColor: nil,
            secondButtonAction: nil,
            buttonTitle: "확인",
            buttonColor: .Sub
        ) {
        }
        
    }
    
    private func makeInputView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("그루터기장 이름(사업자 이름)")
                .font(.b2_R)
                .padding(.top)
            GrewTextField(
                text: $name,
                isWrongText: false,
                isTextfieldDisabled: false,
                placeholderText: "이름",
                isSearchBar: false
            )
            .padding(.bottom, 18)
            
            Text("사업자 등록 번호")
                .font(.b2_R)
            GrewTextField(
                text: $businessNumber,
                isWrongText: !isBusinessNumberValid,
                isTextfieldDisabled: false,
                placeholderText: "000-00-0000",
                isSearchBar: false
            )
            .padding(.bottom, isBusinessNumberValid ? 18 : 0)
            
            if !isBusinessNumberValid {
                HStack {
                    Spacer()
                    Text("양식에 맞게 입력해주세요.")
                        .font(.c2_L)
                        .foregroundStyle(Color.Error)
                }
            }
            
            Text("개인 전화번호")
                .font(.b2_R)
            GrewTextField(
                text: $phoneNumber,
                isWrongText: false,
                isTextfieldDisabled: false,
                placeholderText: "전화번호",
                isSearchBar: false
            )
            .padding(.bottom, 18)
            
            Text("사업자 등록 이미지")
                .font(.b2_R)
            Button {
                isShowingSelectionSheet = true
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                    Text(image == nil ? "사진 추가하기" : "다시 추가하기")
                    Spacer()
                }
                .font(.b1_B)
                .foregroundStyle(Color.DarkGray1)
                .frame(height: 44)
            }
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.DarkGray1)
            )
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func makeImageView() -> some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300)
                .padding(.bottom)
        }
    }
    
    private func makeFinishButton() -> some View {
        Button {
            requestStumpMember()
        } label: {
            Text("신청 하기")
                .frame(width: 343, height: 50)
        }
        .grewButtonModifier(
            width: 343,
            height: 50,
            buttonColor: isFinishButtonDisabled ? .LightGray2 : .Main,
            font: .b1_B,
            fontColor: isFinishButtonDisabled ? .DarkGray1 : .white,
            cornerRadius: 8
        )
        .disabled(isFinishButtonDisabled)
    }
    
    private func requestStumpMember() {
        isLoading = true
        
        if let userId = UserStore.shared.currentUser?.id, let image {
            stumpStore.uploadImage(image: image, path: "stumpMember") { imageURL in
                if let imageURL {
                    do {
                        try stumpStore.addStumpMember(
                            StumpMember(
                                userId: userId,
                                name: name,
                                businessNumber: businessNumber,
                                phoneNumber: phoneNumber,
                                businessImageURL: imageURL,
                                stumpIds: [])
                        )
                        UserStore.shared.currentUser?.isStumpMember = true
                        if let user = UserStore.shared.currentUser {
                            UserStore.shared.updateUser(user: user)
                        }
                        isLoading = false
                        isShowingSuccessAlert = true
                        return
                    } catch {
                        isLoading = false
                        isShowingFailureAlert = true
                        return
                    }
                }
            }
        } else {
            isShowingFailureAlert = true
        }
    }
}


#Preview {
    NavigationStack {
        StumpMemberRequestView(isShowingRequestSheet: .constant(true))
    }
}
