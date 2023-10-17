//
//  KakaoWebController.swift
//  Grew
//
//  Created by daye on 10/17/23.
//

import SwiftUI
import WebKit

/*
    데이터 받아오면 dataArrays[0] = 지번주소, dataArrays[1] = 도로명, dataArrays[2] = 우편번호 들어있음
 */

class KakaoWebData: ObservableObject {
   
    var showingWebSheet: Bool = false
    var messageText: String = ""
    
    // 1. 지번주소, 2. 도로명, 3. 우편번호
    @Published var dataArrays = Array(repeating: "", count: 3)
    //@Environment(\.dismiss) private var dismiss
    
    func textConversion() {
        var decodedInput: String = ""
        
        // 유니코드 변환
        if let data = messageText.data(using: .utf8), let decodedString = String(data: data, encoding: .nonLossyASCII) {
            decodedInput = decodedString
            print(decodedInput)
        }
        
        // 데이터 나누기
        let components = decodedInput.components(separatedBy: ";\n")
       
        for component in components {
            if component.contains("jibunAddress") {
                let data = component.replacingOccurrences(of: "jibunAddress = ", with: "")
                if let data = data.split(separator: "\"").dropFirst().first {
                    dataArrays[0] = String(data)
                }
            } else if component.contains("roadAddress") {
                let data = component.replacingOccurrences(of: "roadAddress = ", with: "")
                if let data = data.split(separator: "\"").dropFirst().first {
                    dataArrays[1] = String(data)
                }
            } else if component.contains("zonecode = ") {
                let data = component.replacingOccurrences(of: "zonecode = ", with: "")
                if let data = data.split(separator: " = ").last {
                    dataArrays[2] = String(data)
                }
            }
        }
        print("Data Arrays: \(dataArrays)")
    }
    
    func receiveMessage(_ message: String) {
        DispatchQueue.main.async {
            self.messageText = message
            print("카카오 데이터 클래스 : \(self.messageText)")
            self.textConversion()
        }
    }
}

class KakaoWebController: NSObject, WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "callBackHandler" {
            print("message name : \(message.name)")
            print("post Message : \(message.body)")
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

