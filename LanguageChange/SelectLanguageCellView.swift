//
//  SelectLanguageCellView.swift
//  LanguageChange
//
//  Created by Vlad on 21/6/25.
//

import SwiftUI

struct SelectLanguageCellView: View {
    
    // MARK: - Body
    var body: some View {
        HStack {
            Image(systemName: "globe")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.accentColor)
            
            Text("Current Language")
                .font(.headline)
                .bold()
            
            Spacer()
            
            Text("English")
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
