//
//  ImageEditModalView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/11.
//

import SwiftUI

struct ImageEditModalView: View {
    
    enum Upload {
        case camera
        case picker
    }
    
    @Binding var showModal: Bool
    var selectAction: ((Upload) -> Void)
    
    var body: some View {
        List {
            HStack {
                Button {
                    selectAction(.picker)
                } label: {
                    Label("라이브러리에서 선택", systemImage: "photo.on.rectangle")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .listRowSeparator(.hidden)
            
            HStack {
                Button {
                    selectAction(.camera)
                } label: {
                    Label("사진찍기", systemImage: "camera")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                
                Spacer()
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .padding(.top, 20)
    }
}

#Preview {
    ImageEditModalView(showModal: .constant(true), selectAction: { _ in })
}
