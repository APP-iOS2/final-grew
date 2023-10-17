//
//  ScheduleStore.swift
//  Grew
//
//  Created by daye on 10/17/23.
//

import Foundation
import FirebaseFirestore

class ScheduleStore: ObservableObject {
    @Published var schedules: [Schedule] = []
    
    let dbRef = Firestore.firestore().collection("Schedule")
}
