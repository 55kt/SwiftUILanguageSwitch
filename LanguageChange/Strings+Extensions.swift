//
//  Strings+Extensions.swift
//  LanguageChange
//
//  Created by Vlad on 19/6/25.
//

import Foundation

extension String {
    
    func localized(using languageCode: String) -> String {
        
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            
            return NSLocalizedString(self, comment: "")
        }
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
