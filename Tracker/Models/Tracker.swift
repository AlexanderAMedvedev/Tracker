//
//  Tracker.swift
//  Tracker
//
//  Created by Александр Медведев on 28.11.2023.
//

import Foundation
import UIKit

struct Tracker {
    //let id: UInt
    let name: String
    let color: UIColor
    let emoji: String
    let timetable: TimeTable
}

struct TimeTable {
    let daysInWeek: [Int]
}
