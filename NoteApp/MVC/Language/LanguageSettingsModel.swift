//
//  LanguageSettingsModel.swift
//  NoteApp
//
//  Created by Tatina Dzhakypbekova on 15/5/24.
//

import UIKit

protocol LanguageSettingsModelProtocol: AnyObject {
    func getLanguageSettings()
    
}
struct Language {
    var languageTitle: String
    var language: String
}

class LanguageSettingsModel {
    weak var controller: LanguageSettingsControllerProtocol?
    
    lazy var language: [Language] = [
        Language(languageTitle: "Русский",
                 language: "русский"),
        Language(languageTitle: "Английский",
                 language: "English"),
        Language(languageTitle: "Кыргызский",
                 language: "Кыргыз")
    ]
    init(controller: LanguageSettingsControllerProtocol) {
        self.controller = controller
    }
}

extension LanguageSettingsModel: LanguageSettingsModelProtocol {
    func getLanguageSettings() {
        controller?.onSuccessLanguage(language: language)
    }
    
}



