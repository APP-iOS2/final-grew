//
//  GrewSchedule.swift
//  Grew
//
//  Created by daye on 10/16/23.
//

/* 임시 */

import SwiftUI

struct GrewSchedule: Identifiable {
    var id: UUID
    var gid: String
    var scheduleName: String
    var date: Date
    var guestNumber: Int
    var fee: String // ?
    var location: String
    var color: Color
}
