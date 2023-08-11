//
//  teachers_helperApp.swift
//  teachers-helper
//
//  Created by Richard Menning on 11.08.23.
//

import SwiftUI

@main
struct teachers_helperApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
         ImageViewWithPicker()
        }
    }
}
