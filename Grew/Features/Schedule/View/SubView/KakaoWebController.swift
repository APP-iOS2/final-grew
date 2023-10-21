//
//  KakaoWebController.swift
//  Grew
//
//  Created by daye on 10/17/23.
//

import SwiftUI
import WebKit

/*
 jibunAddress : 지번주소
 roadAddress : 도로명주소
 zonecode : 우편번호
 x(latitude) : 위도
 y(longitude) : 경도
*/

class KakaoWebController: NSObject, WKScriptMessageHandler {
    @Binding var showingWebSheet: Bool
    @Binding var location: String
    @Binding var latitude: String
    @Binding var longitude: String
    
    init(showingWebSheet: Binding<Bool>, location: Binding<String>, latitude: Binding<String>, longitude: Binding<String>) {
        self._showingWebSheet = showingWebSheet
        self._location = location
        self._latitude = latitude
        self._longitude = longitude
    }
    
    // didReceive, 데이터 받아옴
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if message.name == "callBackHandler", let data = message.body as? [String: Any] {
            print("message name : \(message.name)")
            print("post Message : \(message.body)")
            
            print(data["jibunAddress"] as Any)
            print(data["roadAddress"] as Any)
            print(data["x"] as Any)
            print(data["y"] as Any)
            print(data["zonecode"] as Any)
        
            if let roadAddress = (data["roadAddress"]) as? String{
                location = roadAddress
            }
            if let roadLatitude = (data["x"]) as? String{
                latitude = roadLatitude
            }
            if let roadLongitude = (data["y"]) as? String{
                longitude = roadLongitude
            }
            
            print("Binding lacation: \(String(describing: location))")
            print("Binding latitude: \(String(describing: latitude))")
            print("Binding longitude: \(String(describing: longitude))")
            showingWebSheet.toggle()
        }
    }
   
}


struct WebView: UIViewRepresentable {
    let request: URLRequest
    private var webView: WKWebView?
    @Binding var showingWebSheet: Bool
    @Binding var location: String
    @Binding var latitude: String
    @Binding var longitude: String
    
    init(request: URLRequest, showingWebSheet: Binding<Bool>, location: Binding<String>, latitude: Binding<String>, longitude: Binding<String>) {
        self.webView = WKWebView()
        self.request = request
        self._showingWebSheet = showingWebSheet
        self._location = location
        self._latitude = latitude
        self._longitude = longitude
        self.webView?.configuration.userContentController
            .add(KakaoWebController(showingWebSheet: _showingWebSheet, location: _location, latitude: _latitude, longitude: _longitude), name: "callBackHandler")
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
    
    class Coordinator: NSObject, WKNavigationDelegate {
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
