protocol SettingsControllerProtocol: AnyObject{
    func onGetSettings()
    func onSuccessSettings(settings: [Settings])
    func onSuccessNotes()
    func onFailurNotes()
    func onDeleteAllNotes(notes: [Note])
    
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
    func onDeleteAllNotes(notes: [Note]) {
        model?.deleteAllNotes(notes: notes)
    }
    
    func onSuccessNotes() {
        view?.successNotes()
    }
    
    func onFailurNotes() {
        view?.failurNotes()
    }
    
    func onGetSettings() {
        model?.getSettings()
    }
    
    func onSuccessSettings(settings: [Settings]) {
        view?.sucsessSettings(settings: settings)
    }
    
}

