import UIKit

protocol SettingsModelProtocol: AnyObject {
    func getSettings()
    
}
struct Settings {
    var settingsImage: UIImage
    var title: String
    var buttonTitle: String
}

class SettingsModel {
    weak var controller: SettingsControllerProtocol?
    
    lazy var settings: [Settings] = [
            Settings(settingsImage: UIImage(systemName: "network")!,
                     title: "Язык",
                     buttonTitle: "русский"),
            Settings(settingsImage: UIImage(systemName: "moon")!,
                     title: "Темная тема",
                     buttonTitle: ""),
            Settings(settingsImage: UIImage(systemName: "trash")!,
                     title: "Очистить данные",
                     buttonTitle: "")
        ]
    init(controller: SettingsControllerProtocol) {
        self.controller = controller
    }
}

extension SettingsModel: SettingsModelProtocol {
    func getSettings() {
        controller?.onSuccessSettings(settings: settings)
    }
    
}

    

