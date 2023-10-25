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
    
    private let proxyController = ProxyViewController()
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarAccessor>) -> UIViewController {
    
        proxyController.callback = callback
        return proxyController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<TabBarAccessor>) {
    }
    
    /// TabBar를 가져오기 위한 ProxyVC
    private class ProxyViewController: UIViewController {
        
        var callback: (UITabBar) -> Void = { _ in }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
            if let tabBarController = self.tabBarController {
                callback(tabBarController.tabBar)
            }
        }
    }
    
}
