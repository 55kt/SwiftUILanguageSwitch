//
//  MainTabView.swift
//  LanguageChange
//
//  Created by Vlad on 21/6/25.
//

import SwiftUI

struct MainTabView: View {
    // MARK: - Properties
    @AppStorage("MyLanguages") var currentLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"
    @EnvironmentObject var languageManager: LanguageManager
    
    @State private var tabPaths: [String: NavigationPath] = [
        "homeScreen": NavigationPath(),
        "settingsScreen": NavigationPath()
    ]
    
    // MARK: - Body
    var body: some View {
        TabView {
            
            Tab("Home".localized(using: currentLanguage), systemImage: "house") {
                NavigationStack(path: pathBinding(for: "homeScreen")) {
                    HomeScreenView()
                        .navigationTitle("Home".localized(using: currentLanguage))
                }
            }// Home Tab
            
            Tab("Settings".localized(using: currentLanguage), systemImage: "gear") {
                NavigationStack(path: pathBinding(for: "settingsScreen")) {
                    SettingsScreenView()
                        .navigationTitle("Settings".localized(using: currentLanguage))
                }
            }// Settings Tab
            
        }// TabView
    }// Body
    
    // MARK: - Methods
    
    private func pathBinding(for key: String) -> Binding<NavigationPath> {
        Binding<NavigationPath>(
            get: { tabPaths[key] ?? NavigationPath() },
            set: { tabPaths[key] = $0 }
        ) // Binding
    } // Function: pathBinding
    
}// View

// MARK: - Properties
#Preview {
    MainTabView()
}
