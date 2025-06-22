//
//  SelectLanguageCellView.swift
//  LanguageChange
//
//  Created by Vlad on 21/6/25.
//

import SwiftUI

struct SelectLanguageCellView: View {
    @AppStorage("MyLanguages") private var currentLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"
    
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
            
            Text("english".localized(using: currentLanguage))
                .font(.subheadline)
                .foregroundStyle(.gray)
        }// HStack
        .padding(.horizontal)
    }// Body
}// View

// MARK: - Preview
#Preview {
    NavigationStack {
        SelectLanguageCellView()
    }
}
