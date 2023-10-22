//
//  InquiryView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/18.
//

import SwiftUI

struct InquiryView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            InformWebKit(url: "https://plume-patient-2fb.notion.site/dc960315c2dc48e7b4886ad9812f3eb2?pvs=4")
        }
        .navigationTitle("문의하기")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.backward")
                .font(.system(size: 18))
                .foregroundColor(.black)
        }))
    }
}

#Preview {
    InquiryView()
}
