//
//  SettingsScreenView.swift
//  LanguageChange
//
//  Created by Vlad on 21/6/25.
//

import SwiftUI

struct SettingsScreenView: View {
    
    // MARK: - Body
    var body: some View {
        Form {
            
            /// Language selection
            NavigationLink(destination: LanguageSelectionView()) {
                SelectLanguageCellView()
            }
            
        }// Form
    }// Body
}// View

// MARK: - Preview
#Preview {
    NavigationStack {
        SettingsScreenView()
            .navigationTitle("Settings")
    }
}
