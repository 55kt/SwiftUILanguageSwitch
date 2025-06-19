//
//  LanguageSelectionView.swift
//  LanguageChange
//
//  Created by Vlad on 19/6/25.
//

import SwiftUI

struct LanguageSelectionView: View {
    @EnvironmentObject private var languageManager: LanguageManager
    
    @AppStorage("MyLanguages") var currentLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"
    
    @State private var selectedLanguageIndex = 0
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                Text("choose_language".localized(using: currentLanguage))
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                List {
                    
                    if languageManager.supportedLanguages.count > 0 {
                        ForEach(0..<languageManager.supportedLanguages.count, id: \.self) { index in
                            Button {
                                let languageCode = languageManager.supportedLanguages[index]
                                
                                languageManager.setLanguage(languageCode)
                                
                                currentLanguage = languageCode
                                
                                selectedLanguageIndex = index
                                
                                dismiss()
                            } label: {
                                HStack {
                                    Text(languageManager.languageDisplayName(for: languageManager.supportedLanguages[index]))
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    
                                    Spacer()
                                    
                                    if selectedLanguageIndex == index {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundStyle(.blue)
                                            .imageScale(.large)
                                    } else {
                                        Image(systemName: "circle")
                                            .foregroundStyle(.secondary)
                                            .imageScale(.large)
                                    }
                                }
                                
                                .padding(.vertical, 10)
                            }

                        }.onAppear {
                            
                            if let index = languageManager.supportedLanguages.firstIndex(of: currentLanguage) {
                                selectedLanguageIndex = index
                            } else {
                                let defaultLanguage = "en"
                                if let defaultIndex = languageManager.supportedLanguages.firstIndex(of: defaultLanguage) {
                                    selectedLanguageIndex = defaultIndex
                                    currentLanguage = defaultLanguage
                                    languageManager.setLanguage(defaultLanguage)
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                Spacer()
            }
            .navigationTitle(Text("language_selection_title".localized(using: currentLanguage)))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LanguageSelectionView()
        .environmentObject(LanguageManager())
}
