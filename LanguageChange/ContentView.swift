//
//  ContentView.swift
//  LanguageChange
//
//  Created by Vlad on 19/6/25.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("MyLanguages") var currentLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"
    @EnvironmentObject var languageManager: LanguageManager
    @State private var isLanguageSelectionActive = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("welcome_message".localized(using: currentLanguage))
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Button {
                    isLanguageSelectionActive = true
                } label: {
                    Text("change_language".localized(using: currentLanguage))
                }
                .sheet(isPresented: $isLanguageSelectionActive) {
                    LanguageSelectionView()
                        .environmentObject(languageManager)
                }
                .padding(20)

                Text("footer_text".localized(using: currentLanguage))
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .padding(.top, 20)
                    .multilineTextAlignment(.center)
                
                Spacer()
                    .navigationTitle(Text("app_title".localized(using: currentLanguage)))
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LanguageManager())
}
