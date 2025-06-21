//
//  HomeScreenView.swift
//  LanguageChange
//
//  Created by Vlad on 21/6/25.
//

import SwiftUI

struct HomeScreenView: View {
    // MARK: - Properties
    @AppStorage("MyLanguages") var currentLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"
    @EnvironmentObject var languageManager: LanguageManager
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack {
                Text("Hello in the home screen".localized(using: currentLanguage))
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Image(systemName: "house")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.accentColor)
                    .padding()
                    .symbolEffect(.bounce)
            }// VStack
            .padding()
            
            Text("footer_text".localized(using: currentLanguage))
                .font(.footnote)
                .foregroundStyle(.gray)
                .padding(.top, 20)
                .multilineTextAlignment(.center)
                .padding()
        }// ScrollView
        .searchable(text: .constant(""))
    }// Body
}// View

// MARK: - Preview
#Preview {
    NavigationStack {
        HomeScreenView()
            .navigationTitle("Home")
    }
}
