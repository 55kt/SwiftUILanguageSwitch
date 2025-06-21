//
//  LanguageSelectionView.swift
//  LanguageChange
//
//  Created by Vlad on 19/6/25.
//

import SwiftUI

struct LanguageSelectionView: View {
    // MARK: - Properties
    @EnvironmentObject private var languageManager: LanguageManager
    
    @AppStorage("MyLanguages") var currentLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"
    
    @State private var selectedLanguageIndex = 0
    @State private var isLoading = false
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    List {
                        ForEach(0..<languageManager.supportedLanguages.count, id: \.self) { index in
                            let code = languageManager.supportedLanguages[index]
                            let isSelected = selectedLanguageIndex == index
                            let englishNameColor: Color = isSelected ? .blue : .primary
                            let nativeNameColor: Color = isSelected ? .blue.opacity(0.7) : .secondary
                            
                            Button {
                                selectLanguage(at: index)
                            } label: {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(languageManager.languageDisplayName(for: code))
                                            .font(.headline)
                                            .foregroundStyle(englishNameColor)
                                        
                                        Text(languageManager.nativeLanguageName(for: code) ?? code)
                                            .font(.subheadline)
                                            .foregroundStyle(nativeNameColor)
                                    }// VStack
                                    
                                    Spacer()
                                    
                                    if isSelected {
                                        Image(systemName: "checkmark")
                                            .font(.title2)
                                            .foregroundStyle(.blue)
                                    }// if
                                }// HStack
                                .padding(.vertical, 10)
                            }// Select Language Button
                        }// ForEach
                        .onAppear {
                            if let index = languageManager.supportedLanguages.firstIndex(of: currentLanguage) {
                                selectedLanguageIndex = index
                            }
                        }// onAppear
                    }// List
                    .listStyle(InsetGroupedListStyle())
                }// VStack
                
                if isLoading {
                    LoadingOverlayView(text: "Please wait...")
                }
            }// ZStack
            .navigationTitle(Text("language_selection_title".localized(using: currentLanguage)))
            .navigationBarTitleDisplayMode(.inline)
        }// NavigationStack
    }// Body
    
    // MARK: - Helpers
    private func selectLanguage(at index: Int) {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let code = languageManager.supportedLanguages[index]
            
            languageManager.setLanguage(code)
            currentLanguage = code
            selectedLanguageIndex = index
            
            isLoading = false
            dismiss()
        }
    }// selectLanguage function
}// View

// MARK: - Loading Overlay
struct LoadingOverlayView: View {
    var text: String = "Loading..."
    
    var body: some View {
        Color.black.opacity(0.4)
            .ignoresSafeArea()
            .overlay {
                VStack(spacing: 12) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                    
                    Text(text)
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding()
            }
            .transition(.opacity)
    }
}

// MARK: - Preview
#Preview {
    LanguageSelectionView()
        .environmentObject(LanguageManager())
}
