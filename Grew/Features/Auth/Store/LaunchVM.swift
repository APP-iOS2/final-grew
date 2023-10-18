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
    
    private let service = AuthStore.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var user: FirebaseAuth.User?
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        service.$currentUser.sink { [weak self] user in
            self?.user = user
        }
        .store(in: &cancellables)
    }
}
