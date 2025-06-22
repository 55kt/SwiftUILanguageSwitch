//
//  HomeScreenView.swift
//  LanguageChange
//
//  Created by Vlad on 21/6/25.
//

import SwiftUI

struct HomeScreenView: View {
    // MARK: - Properties
    let currentLanguage: String
    @EnvironmentObject var languageManager: LanguageManager
    
    // MARK: - Body
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text("homescreen_central_title".localized(using: currentLanguage))
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
        .searchable(text: .constant(""), prompt: ("search_placeholder".localized(using: currentLanguage)))
        .modifier(CancelButtonLocalizer())
    }// Body
}// View

// MARK: - Preview
#Preview {
    NavigationStack {
        HomeScreenView(currentLanguage: "en")
            .navigationTitle("Home")
    }
}
