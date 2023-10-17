//
//  ProfileHeaderView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/10.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ProfileHeaderView: View {
    @ObservedObject var userStore: UserStore
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var grewViewModel: GrewViewModel
    
    private var backgroundHeight: CGFloat {
        //        let count = CGFloat(ProfileThreadFilter.allCases.count)
        //        return UIScreen.main.bounds.height / count - 100
        return UIScreen.main.bounds.height / 5
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .topLeading) {
                    VStack {
                        Image("mainBackground")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width, height: backgroundHeight)
                            .edgesIgnoringSafeArea(.all)
                            .scaledToFill()
                        
                        Spacer()
                        
                    }
                    
                    VStack(alignment: .leading) {
                        
                        ZStack(alignment: .leading) {
                            RoundSpecificCorners()
                                .offset(x: 0, y: 37.0)
                            
                            
                            ZStack(alignment: .bottomTrailing) {
                                NavigationLink {
                                    EditProfileView(userStore: UserStore(), userViewModel: UserViewModel())
                                } label: {
                                    //                                    AsyncImage(url: URL(string: userStore.currentUser?.userImageURLString ?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")) { img in
                                    //                                        img
                                    //                                            .resizable()
                                    //                                            .aspectRatio(contentMode: .fit)
                                    //                                            .frame(width: 100)
                                    //                                            .clipShape(Circle())
                                    //                                    } placeholder: {
                                    //                                        ProgressView()
                                    //                                    }
                                    
                                    Image(userViewModel.currentUser?.userImageURLString ?? "defaultProfile")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100)
                                        .clipShape(Circle())
                                    
                                }
                                .padding()
                                
                                Image("editIcon")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .aspectRatio(contentMode: .fill)
                                    .offset(x: -10, y: -5)
                                    .imageScale(.large)
                                    .foregroundColor(.black)
                                    .bold()
                                    .padding()
                            }
                        }
                        Text(userStore.currentUser?.nickName ?? "")
                            .padding(.horizontal)
                            .bold()
                        
                        Text(userStore.currentUser?.introduce ?? "")
                            .padding(.horizontal)
                            .font(.caption)
                        
                        Divider()
                        
                    }
                }
            }
        }
    }
}
#Preview {
    NavigationStack {
        ProfileHeaderView(userStore: UserStore(), userViewModel: UserViewModel(), grewViewModel: GrewViewModel())
    }
}
