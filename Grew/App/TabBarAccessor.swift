//
//  TabBarAccessor.swift
//  Grew
//
//  Created by 정유진 on 2023/10/12.
//

import Foundation
import SwiftUI
import UIKit


struct TabBarAccessor: UIViewControllerRepresentable {
    
    var callback: (UITabBar) -> Void
    
    // TabBarAccessor가 메모리에 올라갈 때 proxyController가생성이 된다
    private let proxyController = ProxyViewController()
    
    // 최초에 화면이 그려질 때
    func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarAccessor>) -> UIViewController {
    
        proxyController.callback = callback
        return proxyController
    }
    
    // @State와 같은 상태값이 변경이 되면 update가 호출 됨
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<TabBarAccessor>) {
    }
    
    /// TabBar를 가져오기 위한 ProxyVC
    private class ProxyViewController: UIViewController {
        
        var callback: (UITabBar) -> Void = { _ in }
        
        // 뷰가 그려질 때 tabBarController를 가지고 있으면 tabBar를 콜백으로 올린다
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
            if let tabBarController = self.tabBarController {
                // tabBarController의 tabBar를 클로져로 보낸다
                callback(tabBarController.tabBar)
            }
        }
    }
    
}
