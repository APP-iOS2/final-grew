//
//  StumpRegisterView.swift
//  Grew
//
//  Created by 김효석 on 10/18/23.
//

import SwiftUI

struct StumpRegisterView: View {
    @State private var name: String = ""
    @State private var hours: String = ""
    @State private var minimumMembers: String = ""
    @State private var maximumMembers: String = ""
    @State private var isNeedDeposit: Bool = false
    @State private var deposit: String = ""
    @State private var location: String = ""
    @State private var phoneNumber: String = ""
    @State private var image: UIImage? = nil
    @State private var images: [UIImage?] = [nil, nil, nil]
    
    @State private var isShowingSelectionSheet: Bool = false
    @State private var isShowingCamera: Bool = false
    @State private var isShowingPhotoLibrary: Bool = false
    @State private var isShowingRegisterAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                makeInputView()
                makeAddImageView()
                makeRegisterButton()
            }
            .padding(.horizontal, 20)
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
            isPresented: $isShowingRegisterAlert,
            title: "그루터기 등록이 완료되었습니다!",
            buttonTitle: "확인",
            buttonColor: .Main
        ) {
            // navigationPath
        }
    }
    
    // 입력 텍스트빌드 뷰
    @ViewBuilder
    private func makeInputView() -> some View {
        Text("그루터기 이름")
            .font(.b2_R)
        GrewTextField(
            text: $name,
            isWrongText: false,
            isTextfieldDisabled: false,
            placeholderText: "이름",
            isSearchBar: false
        )
        .padding(.bottom, 18)
        
        HStack {
            Image(systemName: "stopwatch")
                .font(.b2_R)
            Text("운영 시간")
                .font(.b2_R)
            GrewTextField(
                text: $hours,
                isWrongText: false,
                isTextfieldDisabled: false,
                placeholderText: "00:00 ~ 00:00",
                isSearchBar: false
            )
        }
        .padding(.bottom, 18)
        
        HStack {
            Image(systemName: "person.2.fill")
                .font(.b2_R)
            Text("적정 인원")
                .font(.b2_R)
            GrewTextField(
                text: $minimumMembers,
                isWrongText: false,
                isTextfieldDisabled: false,
                placeholderText: "최소 인원",
                isSearchBar: false
            )
            GrewTextField(
                text: $maximumMembers,
                isWrongText: false,
                isTextfieldDisabled: false,
                placeholderText: "최대 인원",
                isSearchBar: false
            )
        }
        .padding(.bottom, 18)
        
        HStack {
            Text("보증금")
                .font(.b2_R)
            Spacer()
            Button {
                isNeedDeposit = true
            } label: {
                Text("있음")
                    .frame(width: 100, height: 32)
            }
            .grewButtonModifier(
                width: 100,
                height: 32,
                buttonColor: isNeedDeposit ? .Sub : .BackgroundGray,
                font: .b2_R,
                fontColor: isNeedDeposit ? .white : .DarkGray1,
                cornerRadius: 8
            )
            
            Button {
                isNeedDeposit = false
            } label: {
                Text("없음")
                    .frame(width: 100, height: 32)
            }
            .grewButtonModifier(
                width: 100,
                height: 32,
                buttonColor: !isNeedDeposit ? .Sub : .BackgroundGray,
                font: .b2_R,
                fontColor: !isNeedDeposit ? .white : .DarkGray1,
                cornerRadius: 8
            )
        }
        GrewTextField(
            text: $deposit,
            isWrongText: false,
            isTextfieldDisabled: isNeedDeposit ? false : true,
            placeholderText: "예: 50,000원",
            isSearchBar: false
        )
        .padding(.bottom, 18)
        
        Text("위치")
            .font(.b2_R)
        GrewTextField(
            text: $location,
            isWrongText: false,
            isTextfieldDisabled: false,
            placeholderText: "00시 00구 00로 00길 00",
            isSearchBar: false
        )
        .padding(.bottom, 18)
        
        Text("그루터기 전화번호")
            .font(.b2_R)
        GrewTextField(
            text: $phoneNumber,
            isWrongText: false,
            isTextfieldDisabled: false,
            placeholderText: "전화번호",
            isSearchBar: false
        )
        .padding(.bottom, 18)
        
    }
    
    @ViewBuilder
    private func makeAddImageView() -> some View {
        Text("사진(3장)")
            .font(.b2_R)
        Button {
            isShowingSelectionSheet = true
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
                .stroke(Color.Black)
        )
        
        HStack{
            ForEach(0..<3) { index in
                if let image = images[index] {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 110)
                } else {
                    Rectangle()
                        .stroke(Color.black)
                        .frame(height: 110)
                }
            }
        }
    }
    
    private func makeRegisterButton() -> some View {
        Button {
            isShowingRegisterAlert = true
        } label: {
            Text("등록하기")
        }
        .grewButtonModifier(
            width: 343,
            height: 50,
            buttonColor: .Main,
            font: .b1_B,
            fontColor: .white,
            cornerRadius: 8
        )
        .padding(.vertical)
        .disabled(
            name.isEmpty ||
            hours.isEmpty ||
            minimumMembers.isEmpty ||
            maximumMembers.isEmpty ||
            location.isEmpty ||
            phoneNumber.isEmpty ||
            (isNeedDeposit ? deposit.isEmpty : false)
        )
    }
}

#Preview {
    NavigationStack {
        StumpRegisterView()
    }
}
