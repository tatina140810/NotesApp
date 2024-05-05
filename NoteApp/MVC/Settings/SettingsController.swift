protocol SettingsControllerProtocol: AnyObject{
    func onGetSettings()
    func onSuccessSettings(settings: [Settings])
    
}
class SettingsController {
    var view: SettingsViewProtocol?
    var model: SettingsModelProtocol?
    
    init(view: SettingsViewProtocol?) {
        self.view = view
        self.model = SettingsModel(controller: self)
    }
    
    
}
extension SettingsController: SettingsControllerProtocol{
    func onGetSettings() {
        model?.getSettings()
    }
    
    func onSuccessSettings(settings: [Settings]) {
        view?.sucsessSettings(settings: settings)
    }
    
}

