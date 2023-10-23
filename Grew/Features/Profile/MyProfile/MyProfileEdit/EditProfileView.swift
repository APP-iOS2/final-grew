//
//  EditProfileView.swift
//  Grew
//
//  Created by da-hye on 2023/10/21
//

import Kingfisher
import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    let user: User
    
    @State private var image: UIImage?
    @State private var name: String = "" /*= ""*/
    @State private var statusMessage: String = "" /*= ""*/
    @State private var showModal: Bool = false
    @State private var showCamera: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var openPhoto = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    showModal = true
                } label: {
                    ZStack(alignment: .bottomTrailing) {
                        if let unwrappedImage = image {
                            //                            Image(uiImage: unwrappedImage)
                            KFImage(URL(string: user.userImageURLString ?? "chatUser"))
                                .placeholder({
                                    ProgressView()
                                })
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(60)
                        } else {
                            Image(uiImage: UIImage(named: "chatUser")!)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(60)
                        }
                        
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .frame(width: 27, height: 27)
                            .foregroundColor(Color.grewMainColor) // 이미지 색상 설정
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 2) // 원형 보더 설정
                            )
                    }

                }
                .padding(.vertical)
                .padding(.top, 10)

          
                VStack(alignment: .leading) {
                    
                    Text("이름")
                        .padding(.top, 20)
                    RoundedRectangle(cornerRadius: 8)
                        .frame(height: 43)
                        .foregroundStyle(Color.LightGray2)
                        .overlay(alignment: .leading) {
                            Text("\(UserStore.shared.currentUser?.nickName ?? "알 수 없음")")
                                .padding()
                                .foregroundColor(Color.DarkGray1)
                        }
                    
                    Text("상태 메세지")
                        .padding(.top, 20)
                    GrewTextField(text: $statusMessage, isWrongText: false, isTextfieldDisabled: false, placeholderText: "상태 메세지를 입력하세요", isSearchBar: false)
                        .padding(.horizontal, 1)
                    
                    Text("생년월일 및 성별")
                        .padding(.top, 20)
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(height: 43)
                            .foregroundColor(Color.LightGray2)
                            .overlay(
                                Text("\(UserStore.shared.currentUser?.dob ?? "생년월일 정보없음")")
                                    .padding(.horizontal, 16)
                                    .foregroundColor(Color.DarkGray1)
                            )
                            .padding(.horizontal, 1)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 100, height: 43)
                            .foregroundColor(Color.LightGray2)
                            .overlay(
                                Text("\(UserStore.shared.currentUser?.gender ?? "성별없음")")
                                    .padding(.horizontal, 16)
                                    .foregroundColor(Color.DarkGray1)
                            )
                            .padding(.leading, 10)
                    }
                }
                Spacer()
            }.font(.b2_R)
                .padding(30)
            //            .frame(maxWidth: .infinity, alignment: .leading)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {
                    self.mode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color.black)
                }))
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            // 프로필 편집
                            saveProfileChanges()
                            dismiss()
                        } label: {
                            Text("저장")
                                .foregroundColor(Color.grewMainColor)
                                .font(.b2_B)
                            
                        }
                        .buttonStyle(.plain)
                    }
                }

        }
        .sheet(isPresented: $showModal, content: {
            ImageEditModalView(showModal: $showModal) { form in
                switch form {
                case .camera:
                    showModal = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showCamera = true
                    }
                case .picker:
                    showModal = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showImagePicker = true
                    }
                }
            }
            .presentationDetents([.height(120), .height(120)])
        })
        .sheet(isPresented: $showImagePicker, content: {
            ImagePicker(imageString: .constant(""), image: $image)
        })
        .sheet(isPresented: $showCamera, content: {
            CameraView(isPresented: $showImagePicker) { uiImage in
                image = uiImage
            }
        })
        .navigationTitle("프로필 편집")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if let user = UserStore.shared.currentUser {
                name = user.nickName
                statusMessage = user.introduce ?? ""
            }
        }
        .refreshable {
            Task {
                try await UserStore.shared.loadUserData()
            }
        }
    }
    
    func saveProfileChanges() {
        if var updatedUser = UserStore.shared.currentUser {
            updatedUser.nickName = name
            updatedUser.introduce = statusMessage
            if let image = image {
                UserStore.shared.uploadProfileImage(image) { success in
                    if success {
                        print("Profile image uploaded successfully!")
                    } else {
                        print("Failed to upload profile image.")
                    }
                }
            }
            UserStore.shared.updateUser(user: updatedUser)
        }
    }
}

#Preview {
    EditProfileView(user: UserStore.shared.currentUser!)
}
