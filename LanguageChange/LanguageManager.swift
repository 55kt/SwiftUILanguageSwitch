//
//  LanguageManager.swift
//  LanguageChange
//
//  Created by Vlad on 19/6/25.
//

import Foundation

class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    @Published var selectedLanguage = "en"
    
    func setLanguage(_ languageCode: String) {
        if Bundle.main.localizations.contains(languageCode) {
            UserDefaults.standard.set([languageCode], forKey: "MyLanguages")
            self.selectedLanguage = languageCode
        }
    }
    
    var supportedLanguages: [String] {
        return ["en", "ru"]
    }
    
    func languageDisplayName(for languageCode: String) -> String {
        
        switch languageCode {
        case "en":
            return "English"
        case "ru":
            return "Russian"
        default:
            return languageCode
        }
    }
}
