//
//  ProfileStore.swift
//  Grew
//
//  Created by daye on 10/22/23.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation
import SwiftUI

class ProfileStore: ObservableObject {
    @Published var myGrew: [Grew]
    @Published var mySchedule: [Schedule]
    @Published var savedGrew: [Grew]
    
    init(){
        myGrew = []
        mySchedule = []
        savedGrew = []
    }
    
    let db = Firestore.firestore()
    func getUserGrew(user: User?) async -> QuerySnapshot? {
        do {
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
        if let snapshot {
            for document in snapshot.documents {
                do {
                    let temp = try document.data(as: Grew.self)
                    myGrews.append(temp)
                } catch {
                    print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
                }
            }
        }
        await allocateMyGrew(grews: myGrews)
        if user != UserStore.shared.currentUser {
            return
        }
        await fetchSchedule(grews: myGrews)
    }
    
    func getUserSchedule(grews: [Grew]?) async -> QuerySnapshot? {
        do {
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

        if let snapshot {
            for document in snapshot.documents {
                do {
                    let temp = try document.data(as: Schedule.self)
                    mySchedule.append(temp)
                } catch {
                    print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
                }
            }
        }
        await allocateMySchedule(schedules: mySchedule)
    }
    
    func getMyLikeGrew(user: User?) async -> QuerySnapshot? {
        do {
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
        }
        await allocateMyLikedGrew(grews: myGrews)
    }
}
