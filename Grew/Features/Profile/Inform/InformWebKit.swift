//
//  InformWebKit.swift
//  Grew
//
//  Created by 김종찬 on 10/20/23.
//

import SwiftUI
import WebKit

struct InformWebKit: UIViewRepresentable  {
    
    let url: String
    
    func makeUIView(context: Context) -> some UIView {
        let webView: WKWebView = WKWebView()
        
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#Preview {
    InformWebKit(url: "https://github.com/APPSCHOOL3-iOS/final-grew")
}
