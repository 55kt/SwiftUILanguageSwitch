//
//  SelectLanguageCellView.swift
//  LanguageChange
//
//  Created by Vlad on 21/6/25.
//

import SwiftUI

struct SelectLanguageCellView: View {
    let languageManager: LanguageManager
    let currentLanguage: String
    
    // MARK: - Body
    var body: some View {
        HStack {
            Image(systemName: "globe")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.accentColor)
            
            Text("current_language".localized(using: currentLanguage))
                .font(.headline)
                .bold()
            
            Spacer()
            
            Text(languageManager.nativeLanguageName(for: currentLanguage) ?? currentLanguage)
                .font(.subheadline)
                .foregroundStyle(.gray)
        }// HStack
        .padding(.horizontal)
    }// Body
}// View

// MARK: - Preview
#Preview {
    NavigationStack {
        SelectLanguageCellView(languageManager: LanguageManager(), currentLanguage: "en")
            .environmentObject(LanguageManager())
    }
}
