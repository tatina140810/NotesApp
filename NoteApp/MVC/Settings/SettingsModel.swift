import UIKit

protocol SettingsModelProtocol: AnyObject {
    func getSettings()
    func deleteAllNotes(notes: [Note])
    
}
struct Settings {
    var settingsImage: UIImage
    var title: String
    var buttonTitle: String
}

class SettingsModel {
    weak var controller: SettingsControllerProtocol?
    private var notes: [Note] = []
    
    private let coreDataService = CoreDataServices.shared
    
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
    func deleteAllNotes(notes: [Note]) {
        CoreDataServices.shared.deleteAllNotes(in: "Note") { response in
            if response == .failur {
                self.controller?.onFailurNotes()
            } else if response == .success{
                self.controller?.onSuccessNotes()
            }
        }
    }

    
    func getSettings() {
        controller?.onSuccessSettings(settings: settings)
    }
    
}



