//
//  Tracker.swift
//  Tracker
//
//  Created by Александр Медведев on 28.11.2023.
//

import Foundation
import UIKit

struct Tracker {
    let id: UUID
    let name: String
    let color: UIColor
    let emoji: String
    let schedule: [Int]
    let records: [TrackerRecord]
}
