//
//  KakaoWebController.swift
//  Grew
//
//  Created by daye on 10/17/23.
//

import SwiftUI
import WebKit


class KakaoWebData: ObservableObject {
    static let kakaoWebData = KakaoWebData()
    
    var messageText: String = ""

    public func getKakaoMessage() -> String {
        self.messageText
    }
    
    func receiveMessage(_ message: String) {
        DispatchQueue.main.async {
            self.messageText = message
            print("카카오 데이터 클래스 : \(self.messageText)")
        }
    }
}

class KakaoWebController: NSObject, WKScriptMessageHandler {
  
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "callBackHandler" {
            print("message name : \(message.name)")
            print("post Message : \(message.body)")
            KakaoWebData.kakaoWebData.receiveMessage("\(message.body)")
        }
    }
}

struct WebView: UIViewRepresentable {
    let request: URLRequest
    private var webView: WKWebView?
    
    init(request: URLRequest) {
        self.webView = WKWebView()
        self.request = request
        self.webView?.configuration.userContentController.add(KakaoWebController(), name: "callBackHandler")
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView!
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject {
        let parent: WebView
        
        init(parent: WebView) {
            self.parent = parent
        }
    
    }
}

extension WebView {
    func callJS(_ args: Any = "") {
        webView?.evaluateJavaScript("postMessageToiOS('\(args)')") { result, error in
            if let error {
                print("Error \(error.localizedDescription)")
                return
            }
            
            if result == nil {
                print("It's void function")
                return
            }
            
            print("Received Data \(result ?? "")")
        }
    }
}

