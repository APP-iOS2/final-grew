//
//  LaunchVM.swift
//  Grew
//
//  Created by 김종찬 on 10/11/23.
//

import Combine
import Firebase
import FirebaseAuth
import Foundation

class LaunchVM: ObservableObject {
    
    private let authService = AuthStore.shared
    private let userService = UserStore.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var authuser: FirebaseAuth.User?
    @Published var currentuser: User?
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        authService.$currentUser.sink { [weak self] user in
            self?.authuser = user
        }
        .store(in: &cancellables)
        
        userService.$currentUser.sink { [weak self] user in
            self?.currentuser = user
        }
        .store(in: &cancellables)
    }
}
