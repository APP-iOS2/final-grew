//
//  CircularProfileImageView.swift
//  ChattingModule
//
//  Created by cha_nyeong on 9/27/23.
//

import Kingfisher
import SwiftUI

// 이미지 열거형
enum ImageConstants {
    case bubble
    case chatRoomList
    case profile
    
    var size: (width: CGFloat, height: CGFloat) {
        switch self {
        case .bubble:
            (Constant.bubble, Constant.bubble)
        case .chatRoomList:
            (Constant.chatRoomList, Constant.chatRoomList)
        case .profile:
            (Constant.profilePageImage, Constant.profilePageImage)
        }
    }
}

struct CircularProfileImageView: View {
    
    let chatMessage: ChatMessage?
    let url: String?
    let imagesize: ImageConstants
    
    var body: some View {
        if let chatMessage {
            getProfilePhoto(chatMessage: chatMessage)
        }
        if let url {
            getProfilePhoto(url: url)
        }
    }
    
    @ViewBuilder
    private func getProfilePhoto(chatMessage: ChatMessage) -> some View {
        if let profilePhotoURL = chatMessage.displayProfilePhotoURL {
            KFImage.url(profilePhotoURL)
                .placeholder { _ in
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: imagesize.size.width))
                }
                .resizable()
                .frame(width: imagesize.size.width, height: imagesize.size.height)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.crop.circle")
                .font(.system(size: imagesize.size.width))
        }
    }
    
    @ViewBuilder
    private func getProfilePhoto(url: String?) -> some View {
        if let url {
            KFImage.url(URL(string: url))
                .placeholder { _ in
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: imagesize.size.width))
                }
                .resizable()
                .frame(width: imagesize.size.width, height: imagesize.size.height)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.crop.circle")
                .font(.system(size: imagesize.size.width))
        }
    }
    
}

#Preview {
    CircularProfileImageView(chatMessage: ChatMessage.dummyChat, url: nil, imagesize: .bubble)
}
