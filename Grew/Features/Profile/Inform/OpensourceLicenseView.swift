//
//  OpensoureLicenseView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/18.
//

import AcknowList
import SwiftUI

struct OpensourceLicenseView: View {
     
     @Environment(\.dismiss) private var dismiss
     @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        VStack {
            LicenseView()
        }
        .navigationTitle("오픈소스 라이센스")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.backward")
                .foregroundColor(.black)
        }))
    }
}

struct LicenseView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let acknowledgementsViewController = AcknowListViewController()
        return acknowledgementsViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No update needed
    }
}

#Preview {
    OpensourceLicenseView()
}
