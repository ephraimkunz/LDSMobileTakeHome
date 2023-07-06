//
//  LDSMobileTakeHomeApp.swift
//  LDSMobileTakeHome
//
//  Created by Ephraim Kunz on 7/5/23.
//

import SwiftUI
import SwiftData

@main
struct LDSMobileTakeHomeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Individual.self)
    }
}
