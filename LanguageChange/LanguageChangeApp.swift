//
//  LanguageChangeApp.swift
//  LanguageChange
//
//  Created by Vlad on 19/6/25.
//

import SwiftUI

@main
struct LanguageChangeApp: App {
    @StateObject var languageManager = LanguageManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(languageManager)
        }
    }
}
