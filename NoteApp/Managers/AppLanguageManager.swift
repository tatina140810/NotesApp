//
//  AppLanguageManager.swift
//  NoteApp
//
//  Created by Tatina Dzhakypbekova on 22/5/24.
//

import Foundation

enum LanguageType: String {
    case kg = "ky"
    case ru = "ru"
    case en = "en"
}

class AppLanguageManager{
    static let shared = AppLanguageManager()
    
    private var currentLanguage: LanguageType?
    
    private var currentBundle: Bundle = Bundle.main
    
    var bundle: Bundle {
        return currentBundle
    }
    private func setCurrentBundlePath(languageCode: String) {
        guard let bundle = Bundle.main.path(forResource: languageCode, ofType: "lproj"), let langeBundle = Bundle(path: bundle) else {
            return
        }
        currentBundle = langeBundle
        
    }
    private func setCurrentLanguage(languageType: LanguageType) {
        currentLanguage = languageType
//        UserDefaults.standard.set(currentLanguage, forKey: "Theme")
    }
    
    func setAppLanguage(languageType: LanguageType){
        setCurrentLanguage(languageType: languageType)
        setCurrentBundlePath(languageCode: languageType.rawValue)
    }
    
    
}

extension String {
    func localised() -> String {
        let bundle = AppLanguageManager.shared.bundle
        return NSLocalizedString(self, tableName: "Localizable", bundle: bundle, comment:"")
    }
}
