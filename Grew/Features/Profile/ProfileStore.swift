//
//  ProfileStore.swift
//  Grew
//
//  Created by daye on 10/23/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class Profile: ObservableObject {
    @Published var myGrew: [Grew] = []
    @Published var mySchedule: [Schedule] = []
    @Published var savedGrew: [Grew] = [] // ?0? 멍미
    
    let db = Firestore.firestore()

    func fetchProfileGrew() {
        if let user = UserStore.shared.currentUser {
            db.collection("grews")
                .whereField("currentMembers", arrayContains: user.id ?? "")
                .getDocuments { snapshot, error in
                    guard let documents = snapshot?.documents, error == nil else {
                        if let error = error { print(error) }
                        return
                    }

                    var fetchData: [Grew] = []
                    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@프로필 그루 패치!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                    for document in documents {
                        do {
                            let temp = try document.data(as: Grew.self)
                            fetchData.append(temp)
                            print(temp)
                        } catch {
                            print("fetch Profile Grew Error\(error)")
                        }
                    }

                    self.myGrew = fetchData
                }
        }else {
            print("로그인 오류")
        }
    }

    func fetchProfileSchedule() {
        db.collection("schedule").getDocuments { snapshot, error in
                guard let documents = snapshot?.documents, error == nil else {
                    if let error = error { print(error) }
                    return
                }
            print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@프로필 스케쥴 패치!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
            var fetchData: [Schedule] = []
            for document in documents {
                do {
                    let temp = try document.data(as: Schedule.self)
                    for grew in self.myGrew {
                        if temp.gid == grew.id {
                            fetchData.append(temp)
                            print(temp)
                        }
                    }
                } catch {
                    print("fetch Profile Schedule Error\(error)")
                }
            }

            self.mySchedule = fetchData
        }
    }
}
