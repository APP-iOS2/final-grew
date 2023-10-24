//
//  ScheduleStore.swift
//  Grew
//
//  Created by daye on 10/17/23.
//

import FirebaseFirestore
import Foundation

class ScheduleStore: ObservableObject {
    @Published var schedules: [Schedule] = []
    @Published var date = Date()
    let dbRef = Firestore.firestore().collection("schedule")
    
    init(){
        fetchSchedule()
    }
    
    func fetchSchedule() {
        dbRef.getDocuments {snapshot, error in
            guard let documents = snapshot?.documents, error == nil else {
                if let error = error { print(error) }
                return
            }
            var fetchData: [Schedule] = []
            
            for document in documents {
                do {
                    let temp = try document.data(as: Schedule.self)
                    fetchData.append(temp)
                } catch {
                    print("*** error ***\(error)")
                }
            }
            self.schedules = fetchData
        }
    }
    
    func addSchedule(_ schedule: Schedule){
        guard let scheduelData = try? Firestore.Encoder().encode(schedule) else { return }
        
        dbRef.document(schedule.id).setData(scheduelData)
        fetchSchedule()
    }
    
    
    func updateParticipants(_ participants: [String], scheduleId: String) {
        dbRef.whereField("id", isEqualTo: scheduleId).getDocuments { snapshot, error in
            if let error {
                print("Error: \(error)")
            } else if let snapshot {
                for document in snapshot.documents {
                    self.dbRef.document(document.documentID).updateData([
                        "participants" : participants
                    ]) { error in
                        if let error {
                            print("Grew Update Error: \(error)")
                        } else {
                            self.fetchSchedule()
                        }
                    }
                }
            }
        }
    }
    
    func removeSchedule(_ schedule: Schedule) {
        dbRef.document(schedule.id).delete()
        fetchSchedule()
    }
    
    func removeSchedule(gid: String) async {
        do {
            let snapshot = try await dbRef.whereField("gid", isEqualTo: gid).getDocuments()
            for document in snapshot.documents {
                try await document.reference.delete()
            }
        } catch {
            print("Remove schedule error: \(error)")
        }
    }
}
