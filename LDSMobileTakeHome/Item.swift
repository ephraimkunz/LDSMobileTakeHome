//
//  Item.swift
//  LDSMobileTakeHome
//
//  Created by Ephraim Kunz on 7/5/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
