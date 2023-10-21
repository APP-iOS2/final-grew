//
//  StumpRegisterView.swift
//  Grew
//
//  Created by 김효석 on 10/18/23.
//

import SwiftUI

struct StumpRegisterView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var stumpStore: StumpStore
    
    @State private var name: String = ""
    @State private var hours: String = ""
    @State private var minimumMembers: String = ""
    @State private var maximumMembers: String = ""
    @State private var isNeedDeposit: Bool = false
    @State private var deposit: String = ""
    @State private var location: String = ""
    @State private var phoneNumber: String = ""
    @State private var image: UIImage? = nil
    @State private var images: [UIImage?] = []
    @State private var imageURLs: [String] = []
    
    @State private var isShowingPhotoSelectionSheet: Bool = false
    @State private var isShowingCamera: Bool = false
    @State private var isShowingPhotoLibrary: Bool = false
    @State private var isShowingSuccessAlert: Bool = false
    @State private var isShowingFailureAlert: Bool = false
    @State private var isShowingNotStumpMemberAlert: Bool = false
    @State private var isShowingUserFailureAlert: Bool = false
    @State private var isLoading = false
    
    let imagesLength: Int = 3
    
    private var isRegisterButtonDisabled: Bool {
        name.isEmpty ||
        hours.isEmpty ||
        minimumMembers.isEmpty ||
        maximumMembers.isEmpty ||
        location.isEmpty ||
        phoneNumber.isEmpty ||
        (isNeedDeposit ? deposit.isEmpty : false) ||
        images.count < 3
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
//                makeInputView()
                StumpInputView(
                    name: $name,
                    hours: $hours,
                    minimumMembers: $minimumMembers,
                    maximumMembers: $maximumMembers,
                    isNeedDeposit: $isNeedDeposit,
                    deposit: $deposit,
                    location: $location,
                    phoneNumber: $phoneNumber,
                    isAllTextFieldDisabled: false
                )
                
                makeAddImageView()
                
                makeRegisterButton()
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("그루터기 등록하기")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 18))
                        .foregroundStyle(Color.black)
                }
                Spacer()
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
        .onAppear {
            if UserStore.shared.currentUser == nil {
                isShowingUserFailureAlert = true
            } else if let isStumpMember = UserStore.shared.currentUser?.isStumpMember, !isStumpMember {
                isShowingNotStumpMemberAlert = true
            } else {
                isShowingNotStumpMemberAlert = false
            }
        }
        .sheet(isPresented: $isShowingPhotoSelectionSheet) {
            ImageEditModalView(showModal: $isShowingPhotoSelectionSheet) { form in
                switch form {
                case .camera:
                    isShowingPhotoSelectionSheet = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isShowingCamera = true
                    }
                case .picker:
                    isShowingPhotoSelectionSheet = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isShowingPhotoLibrary = true
                    }
                }
            }
            .presentationDetents([.height(120), .height(120)])
        }
        .sheet(isPresented: $isShowingPhotoLibrary) {
            ImagePicker(image: $image)
        }
        .sheet(isPresented: $isShowingCamera) {
            CameraView(isPresented: $isShowingCamera) { uiImage in
                image = uiImage
            }
        }
        .onReceive(image.publisher) { newImage in
            if images.count < 3, newImage != images.last {
                images.append(newImage)
                image = nil
            } else if images.count == 3 {
                images.removeLast()
                images.append(newImage)
                image = nil
            }
        }
        .grewAlert(
            isPresented: $isShowingSuccessAlert,
            title: "그루터기 등록이 완료되었습니다!",
            secondButtonTitle: nil,
            secondButtonColor: nil,
            secondButtonAction: nil,
            buttonTitle: "확인",
            buttonColor: .Main,
            action: { dismiss() }
        )
        .grewAlert(
            isPresented: $isShowingFailureAlert,
            title: "그루터기 등록에 실패했습니다.",
            secondButtonTitle: nil,
            secondButtonColor: nil,
            secondButtonAction: nil,
            buttonTitle: "확인",
            buttonColor: .Error,
            action: {}
        )
        .grewAlert(
            isPresented: $isShowingNotStumpMemberAlert,
            title: "그루터기 멤버가 아닙니다.\n먼저 그루터기 멤버가\n되어주세요!",
            secondButtonTitle: nil,
            secondButtonColor: nil,
            secondButtonAction: nil,
            buttonTitle: "확인",
            buttonColor: .Main,
            action: { dismiss() }
        )
        .grewAlert(
            isPresented: $isShowingUserFailureAlert,
            title: "유저 정보를 가져오는 데 실패했습니다.",
            secondButtonTitle: nil,
            secondButtonColor: nil,
            secondButtonAction: nil,
            buttonTitle: "확인",
            buttonColor: .Error,
            action: { dismiss() }
        )
    }
}

// 뷰 반환 함수
extension StumpRegisterView {
    // 사진 추가 뷰
    @ViewBuilder
    private func makeAddImageView() -> some View {
        HStack {
            Text("사진(3장)")
            if !images.isEmpty {
                Spacer()
                Button {
                    images.removeLast()
                } label: {
                    Text("마지막 사진 삭제")
                        .foregroundStyle(.red)
                }
            }
        }
        .font(.b2_R)
        Button {
            isShowingPhotoSelectionSheet = true
        } label: {
            HStack {
                Spacer()
                Image(systemName: "plus")
                Text("사진 추가하기")
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
        
        HStack{
            ForEach(0..<3) { index in
                if index < images.count {
                    if let image = images[index] {
                        ZStack {
                            Rectangle()
                                .stroke(Color.black)
                                .frame(height: 110)
                            
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 110, height: 110)
                        }
                    }
                } else {
                    Rectangle()
                        .stroke(Color.black)
                        .frame(height: 110)
                }
            }
        }
    }
    
    // 등록 버튼 View
    private func makeRegisterButton() -> some View {
        Button {
            stumpRegister()
        } label: {
            Text("등록하기")
        }
        .grewButtonModifier(
            width: 343,
            height: 50,
            buttonColor: isRegisterButtonDisabled ? .LightGray2 : .Main,
            font: .b1_B,
            fontColor: isRegisterButtonDisabled ? .DarkGray1 : .white,
            cornerRadius: 8
        )
        .padding(.vertical)
        .disabled(isRegisterButtonDisabled)
    }
}

// 기능 함수
extension StumpRegisterView {
    /// 그루터기 등록 함수
    private func stumpRegister() {
        isLoading = true
        
        if let userId = UserStore.shared.currentUser?.id {
            let dispatchGroup = DispatchGroup()
            
            for image in images {
                guard let image else {
                    isShowingFailureAlert = true
                    return
                }
                
                dispatchGroup.enter()
                stumpStore.uploadImage(image: image, path: "stumps") { imageURL in
                    if let imageURL {
                        imageURLs.append(imageURL)
                    }
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                do {
                    try stumpStore.addStump(
                        Stump(
                            stumpMemberId: userId,
                            name: name,
                            hours: hours,
                            minimumMembers: minimumMembers,
                            maximumMembers: maximumMembers,
                            isNeedDeposit: isNeedDeposit,
                            deposit: deposit,
                            location: location,
                            phoneNumber: phoneNumber,
                            imageURLs: imageURLs
                        )
                    )
                    Task {
                        await stumpStore.updateStumpMember(userId: userId)
                    }
                    isLoading = false
                    isShowingSuccessAlert = true
                } catch {
                    isLoading = false
                    isShowingFailureAlert = true
                    return
                }
            }
        } else {
            isShowingFailureAlert = true
            return
        }
    }
}

#Preview {
    NavigationStack {
        StumpRegisterView()
            .navigationTitle("그루터기 등록하기")
            .navigationBarTitleDisplayMode(.inline)
    }
}
