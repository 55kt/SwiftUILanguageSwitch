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
    
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("choose_language".localized(using: currentLanguage))
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    List {
                        ForEach(0..<languageManager.supportedLanguages.count, id: \.self) { index in
                            Button {
                                selectLanguage(at: index)
                            } label: {
                                HStack {
                                    Text(languageManager.languageDisplayName(for: languageManager.supportedLanguages[index]))
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    
                                    Spacer()
                                    
                                    Image(systemName: selectedLanguageIndex == index ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(selectedLanguageIndex == index ? .blue : .secondary)
                                        .imageScale(.large)
                                }
                                .padding(.vertical, 10)
                            }
                        }
                        .onAppear {
                            if let index = languageManager.supportedLanguages.firstIndex(of: currentLanguage) {
                                selectedLanguageIndex = index
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    
                    Spacer()
                }
                
                if isLoading {
                    LoadingOverlayView(text: "Please wait...")
                }
            }
            .navigationTitle(Text("language_selection_title".localized(using: currentLanguage)))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Helpers
    private func selectLanguage(at index: Int) {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let languageCode = languageManager.supportedLanguages[index]
            
            languageManager.setLanguage(languageCode)
            currentLanguage = languageCode
            selectedLanguageIndex = index
            
            isLoading = false
            dismiss()
        }
    }
}

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

#Preview {
    LanguageSelectionView()
        .environmentObject(LanguageManager())
}
