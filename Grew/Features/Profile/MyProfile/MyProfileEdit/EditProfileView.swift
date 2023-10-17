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
    
    @State var image: UIImage = UIImage(named: "defaultProfile")!
    @State var name: String = ""
    @State var introduce: String = ""
    @State var showModal: Bool = false
    @State var showCamera: Bool = false
    @State var showImagePicker: Bool = false
    @State private var openPhoto = false
    
    var userStore: UserStore
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Button {
                    showModal = true
                } label: {
                    ZStack(alignment: .bottomTrailing) {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 120, height: 120)
                            .cornerRadius(60)
                        
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 27, height: 27)
                            .foregroundColor(Color(hex: 0x25C578)) // 이미지 색상 설정
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 2) // 원형 보더 설정
                            )
                    }
                    .padding(.vertical)
                }
                
                VStack(alignment: .leading) {
                    Text("이름")
                        .bold()
                        .font(.title3)
                    
                    TextField("\(userViewModel.currentUser?.nickName ?? "")", text: $name)
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.gray))
                        .frame(height: 50)
                }
                .padding(.vertical)
                
                VStack(alignment: .leading) {
                    Text("자기소개")
                        .bold()
                        .font(.title3)
                    
                    TextEditor(text: .constant("\(userViewModel.currentUser?.introduce ?? "")"))
                        .overlay(RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.gray))
                        .frame(height: 150)
                    
                    Spacer()
                }
            }
//            .frame(maxWidth: .infinity, alignment: .leading)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.mode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.backward")
                    .foregroundColor(Color(hex: 0x25C578))
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
                            .background(Color(hex: 0x25C578))
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
                if let user = userViewModel.currentUser {
                    name = user.nickName
                    introduce = user.introduce ?? ""
                }
            }
        }
    }
    
    func saveProfileChanges() {
        if var updatedUser = userViewModel.currentUser {
            updatedUser.nickName = name
            updatedUser.introduce = introduce
            userViewModel.uploadProfileImage(image) { success in
                if success {
                    print("Profile image uploaded successfully!")
                } else {
                    print("Failed to upload profile image.")
                }
            }
            userViewModel.updateUser(user: updatedUser)
        }
    }
}

#Preview {
    EditProfileView(userStore: UserStore(), userViewModel: UserViewModel())
}
