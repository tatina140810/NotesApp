protocol LanguageSettingsControllerProtocol: AnyObject{
    func onGetLanguageSettings()
    func onSuccessLanguage(language: [Language])
    
}
class LanguageSettingsController {
    var view: LanguageSettingsViewProtocol?
    var model: LanguageSettingsModelProtocol?
    
    init(view: LanguageSettingsViewProtocol?) {
        self.view = view
        self.model = LanguageSettingsModel(controller: self)
    }
    
    
}
extension LanguageSettingsController: LanguageSettingsControllerProtocol{
    func onGetLanguageSettings() {
        model?.getLanguageSettings()
    }
    
    func onSuccessLanguage(language: [Language]) {
        view?.sucsessLanguage(language: language)
    }
    
}

