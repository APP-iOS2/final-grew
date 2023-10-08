//
//  EditProfileView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/09/21.
//

import SwiftUI

struct EditProfileView: View {
    var userStore: UserStore
    
    @State var username: String = ""
    @State var userIntro: String = ""
    @State private var openPhoto = false
    @State private var image = UIImage()
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Button {
                    self.openPhoto = true

                } label: {
                    AsyncImage(url: URL(string: userStore.currentUser.userImageURLString ?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")) { img in
                        img
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
//                                    Image(uiImage: self.image)
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(width: 100)
//                                        .clipShape(Circle())
                    .sheet(isPresented: $openPhoto, content: {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    })
                }
                
                VStack(alignment: .leading) {
                    Text("이름")
                        .bold()
                        .font(.title3)
                    
                    TextField("\(userStore.currentUser.nickName)", text: $username)
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
                    
                    TextEditor(text: .constant("\(userStore.currentUser.introduce ?? "")"))
                        .overlay(RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.gray))
                        .frame(height: 150)
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // Firebase - update
                    } label: {
                        Text("저장")
                    }
                    .accentColor(Color(hex: 0x25C578))
                }
            }
        }
    }
}

#Preview {
    EditProfileView(userStore: UserStore())
}
