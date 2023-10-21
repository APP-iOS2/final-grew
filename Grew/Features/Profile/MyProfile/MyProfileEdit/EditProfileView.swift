//
//  EditProfileView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/09/21.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var image: UIImage? = UIImage(named: "defaultProfile")
    @State var name: String /*= ""*/
    @State var statusMessage: String /*= ""*/
    @State var showModal: Bool = false
    @State var showCamera: Bool = false
    @State var showImagePicker: Bool = false
    @State private var openPhoto = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Button {
                    showModal = true
                } label: {
                    ZStack(alignment: .bottomTrailing) {
                        if let unwrappedImage = image {
//                            Image(uiImage: unwrappedImage)
                            AsyncImage(url: URL(string: UserStore.shared.currentUser?.userImageURLString ?? "defaultProfile"), content: { image in
                                image
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(60)
                            }, placeholder: {
                                ProgressView()
                            })
                                
                            
                            Image(systemName: "plus.circle.fill")
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
                }
                
                VStack(alignment: .leading) {
                    Text("이름")
                        .bold()
                        .font(.title3)
                    
                    RoundedRectangle(cornerRadius: 7)
                        .frame(height: 60)
                        .foregroundStyle(Color.LightGray2)
                        .overlay(alignment: .leading) {
                            Text("\(UserStore.shared.currentUser?.nickName ?? "알 수 없음")")
                                .padding()
                                .foregroundColor(Color.DarkGray1)
                        }
                    
                    
                }
                .padding(.vertical)
                
                VStack(alignment: .leading) {
                    Text("상태 메세지")
                        .bold()
                        .font(.title3)
                      
                    RoundedRectangle(cornerRadius: 7)
                        .frame(height: 60)
                        .foregroundColor(Color.BackgroundGray)
                        .overlay(
                            TextField("상태 메세지를 입력하세요", text: $statusMessage)
                                .padding(.horizontal, 16)
                                
                        )
                        .padding(.horizontal, 1)
                        .padding(.vertical, 4)
                    
                    Text("생년월일 및 성별")
                        .bold()
                        .font(.title3)
                        .padding(.vertical, 5)
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 7)
                            .frame(height: 60)
                            .foregroundColor(Color.LightGray2)
                            .overlay(
                                Text("\(UserStore.shared.currentUser?.dob ?? "생년월일 정보없음")")
                                    .padding(.horizontal, 16)
                                    .foregroundColor(Color.DarkGray1)
                            )
                            .padding(.vertical, 10)
                        
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 100,height: 60)
                            .foregroundColor(Color.LightGray2)
                            .overlay(
                                Text("\(UserStore.shared.currentUser?.gender ?? "성별없음")")
                                    .padding(.horizontal, 16)
                                    .foregroundColor(Color.DarkGray1)
                                
                            )
                            .padding(.horizontal, 10)
                    }
                    
                    Spacer()
                }
            }
//            .frame(maxWidth: .infinity, alignment: .leading)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.mode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.backward")
                    .foregroundColor(Color.black)
            }))
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // 프로필 편집
                        saveProfileChanges()
                        dismiss()
                    } label: {
                        Text("저장")
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.grewMainColor)
                            .cornerRadius(5)
                    }
                    .buttonStyle(.plain)
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
                ImagePicker(image: $image)
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
    EditProfileView(name: "헬롱", statusMessage: "하위")
}
