//
//  ProfileStore.swift
//  Grew
//
//  Created by daye on 10/22/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

class ProfileStore: ObservableObject {
    @Published var myGrew: [Grew]
    @Published var mySchedule: [Schedule]
    @Published var savedGrew: [Grew] // ?0? 멍미 찜한 그루
    
    init(){
        myGrew = []
        mySchedule = []
        savedGrew = []
    }
    
    let db = Firestore.firestore()
    
    func getUserGrew(user: User?) async -> QuerySnapshot? {
        do {
            print(user)
            guard let user else {
                return nil
            }
            let snapshot = try await db
                .collection("grews")
                .whereField("currentMembers", arrayContains: user.id ?? "")
                .getDocuments()
            return snapshot
        } catch {
            print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
        }
        return nil
    }
    
    @MainActor
    func allocateMyGrew(grews: [Grew]) {
        self.myGrew = grews
    }
    
    
    func fetchProfileData(user: User?) async {
        var snapshot = await getUserGrew(user: user)
        
        var myGrews: [Grew] = []
        print("@@@@@@@@@@@@@@@@@@@@@@프로필 그루 패치!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        
        if let snapshot {
            for document in snapshot.documents {
                do {
                    let temp = try document.data(as: Grew.self)
                    myGrews.append(temp)
                    print(temp)
                } catch {
                    print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
                }
            }
        }
        await allocateMyGrew(grews: myGrews)
        // 유저 조회 시 로그인 된 회원이 아닐 경우 (프로필 조회)
        if user != UserStore.shared.currentUser {
            return
        }
        // 로그인 된 유저이면 마이 페이지 이기때문에 마저 조회
        await fetchSchedule(grews: myGrews)
    }
    
    func getUserSchedule(grews: [Grew]?) async -> QuerySnapshot? {
        do {
            print(grews)
            guard let grews else {
                return nil
            }
            let tempGrewsId = grews.map { grew in
                grew.id
            }
            if tempGrewsId.isEmpty {
                return nil
            }
            
            let snapshot = try await db
                .collection("schedule")
                .whereField("gid", in: tempGrewsId)
                .order(by: "date", descending: false)
                .getDocuments()
            return snapshot
        } catch {
            print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
        }
        return nil
    }
    
    @MainActor
    func allocateMySchedule(schedules: [Schedule]) {
        self.mySchedule = schedules
    }
    
    func fetchSchedule(grews: [Grew]) async {
        let snapshot = await getUserSchedule(grews: grews)
        
        var mySchedule: [Schedule] = []
        print("@@@@@@@@@@@@@@@@@@@@@@프로필 스케줄 패치!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        
        if let snapshot {
            for document in snapshot.documents {
                do {
                    let temp = try document.data(as: Schedule.self)
                    mySchedule.append(temp)
                    print(temp)
                } catch {
                    print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
                }
            }
        }
        await allocateMySchedule(schedules: mySchedule)
    }
    
    func getMyLikeGrew(user: User?) async -> QuerySnapshot? {
        do {
            print(user)
            guard let user else {
                return nil
            }
            let snapshot = try await db
                .collection("grews")
                .getDocuments()
            return snapshot
        } catch {
            print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
        }
        return nil
    }
    
    @MainActor
    func allocateMyLikedGrew(grews: [Grew]) {
        self.savedGrew = grews
    }
    
    
    func fetchProfileLikeGrew(user: User?) async {
        var snapshot = await getMyLikeGrew(user: user)
        
        var myGrews: [Grew] = []
        print("@@@@@@@@@@@@@@@@@@@@@@프로필 찜한 그루 패치!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        
        if let snapshot {
            for document in snapshot.documents {
                do {
                    let temp = try document.data(as: Grew.self)
                    if let result = temp.heartUserDictionary?[UserStore.shared.currentUser!.id!] {
                        if result {
                            myGrews.append(temp)
                        }
                    }
                } catch {
                    print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
                }
            }
            print("\(myGrews)")
        }
        await allocateMyLikedGrew(grews: myGrews)
    }
}
