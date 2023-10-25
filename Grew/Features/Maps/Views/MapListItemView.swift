//
//  MapListItemView.swift
//  Grew
//
//  Created by 마경미 on 10.10.23.
//

import Firebase
import FirebaseFirestoreSwift
import SwiftUI

struct MapListItemView: View {
    
    var item: Grew
    @State var users: [User] = []
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: item.imageURL), content: { image in
                image
                    .resizable()
            }, placeholder: {
                ProgressView()
            })
            .frame(width: 84, height: 84)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Spacer(minLength: 12)
            
            VStack(alignment: .leading) {
                CategoryView(isSmall: true, isSelectable: false, category: item.indexForCategory, handleAction: {
                    
                })
                Text(item.title)
                    .font(.b2_B)
                    .foregroundColor(Color.Black)
                Text(item.description)
                    .font(.c2_B)
                    .foregroundColor(Color.DarkGray1)
                HStack {
                    Group {
                        ForEach(users, id: \.self) { user in
                            VStack {
                                if user.userImageURLString == nil {
                                    Image("defaultUserProfile")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .clipShape(.capsule)
                                } else {
                                    AsyncImage(url: URL(string: user.userImageURLString ?? ""), content: { image in
                                        image
                                            .resizable()
                                    }, placeholder: {
                                        ProgressView()
                                    })
                                    .frame(width: 24, height: 24)
                                    .clipShape(.capsule)
                                }
                            }
                            .padding(.horizontal, -5)
                        }
                    }
                    Spacer()
                    
                    Group {
                        Image(systemName: "person.2.fill")
                            .font(Font.custom("SF Pro", size: 10))
                            .foregroundColor(Color.DarkGray1)
                        Text("\(item.currentMembers.count)/\(item.maximumMembers)")
                            .font(.c2_B)
                            .foregroundColor(Color.DarkGray1)
                    }
                }
            }
        }.padding(.horizontal, 16)
            .padding(.vertical, 12)
            .onAppear(perform: {
                fetchUsers()
            })
    }
    
    func fetchUsers() {
        Firestore.firestore().collection("users").whereField("id", in: [item.currentMembers]).getDocuments() {
            snapshot, error in
            
            guard let documents = snapshot?.documents else {
                return
            }
            
            for document in documents {
                do {
                    let user = try document.data(as: User.self)
                    users.append(user)
                } catch {
                    print("Can't decoding user")
                }
                
            }
        }
    }
}


#Preview {
    MapListItemView(item: Grew.defaultGrew)
}
