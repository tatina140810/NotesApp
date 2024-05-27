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
    var languageImage: UIImage
    var languageTitle: String
    var language: String
    var languageType: LanguageType
}

class LanguageSettingsModel {
    weak var controller: LanguageSettingsControllerProtocol?
    
    lazy var language: [Language] = [
        Language(languageImage: UIImage(resource: .kyrg),
                 languageTitle: "Кыргызский",
                 language: "Кыргыз", languageType: .kg),
        Language(languageImage: UIImage(resource: .rush),
                 languageTitle: "Русский",
                 language: "русский", languageType: .ru),
        Language(languageImage: UIImage(resource: .usa),
                 languageTitle: "Английский",
                 language: "English", languageType: .en)
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



