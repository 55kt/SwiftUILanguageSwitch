//
//  SettingsScreenView.swift
//  LanguageChange
//
//  Created by Vlad on 21/6/25.
//

import SwiftUI

struct SettingsScreenView: View {
    let currentLanguage: String
    @EnvironmentObject private var languageManager: LanguageManager
    
    // MARK: - Body
    var body: some View {
        Form {
            /// Language selection
            NavigationLink(destination: LanguageSelectionView()) {
                SelectLanguageCellView(
                    languageManager: languageManager, currentLanguage: currentLanguage
                )
            }// NavigationLink
            
        }// Form
    }// Body
}// View

// MARK: - Preview
#Preview {
    NavigationStack {
        SettingsScreenView(currentLanguage: "en")
            .navigationTitle("Settings")
            .environmentObject(LanguageManager())
    }
}
