//
//  FirebaseEnums.swift
//  Grew
//
//  Created by cha_nyeong on 10/5/23.
//

import Foundation

public enum FirestoreCollectionReference: String {
    case users = "Users"
    case chatrooms = "Chatrooms"
    case messages = "Messages"
}

public enum FirestoreResponse {
    case success
    case failure
}
