import UIKit
import SnapKit
protocol SettingsViewProtocol: AnyObject {
    func sucsessSettings(settings: [Settings])
    
}

class SettingsView: UIViewController {
    private var controller: SettingsControllerProtocol?
    
    private var settings: [Settings] = []
    
    private var tableView: UITableView = {
        let view = UITableView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        controller = SettingsController(view: self)
        controller?.onGetSettings()
        navigationControllerSettings()
        tableViewSettings()
        
    }
    
    func tableViewSettings() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(150)
        }
        
    }
    
    private func navigationControllerSettings() {
        navigationItem.title = "Settings"
        
        let label = UIBarButtonItem(title: "Label", style: .plain , target: self, action: #selector(labelButtonTapped))
        label.tintColor = .blue
        
        navigationItem.leftBarButtonItem = label
    }
    @objc func labelButtonTapped() {
        navigationController?.pushViewController(HomeView(), animated: true)
        
    }
    private func updateInterfaceForTheme(isDark: Bool? = nil) {
        if let isDark = isDark {
            UserDefaults.standard.set(isDark, forKey: "Theme")
        }
        
    }
    
}
extension SettingsView: SettingsViewProtocol{
    func sucsessSettings(settings: [Settings]){
        self.settings = settings
        tableView.reloadData()
        
    }
    
}
extension SettingsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = LanguageSettingsView()
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            let acceptAction = UIAlertAction(title: "Yes", style: .cancel) {action in
                if indexPath.row == 2 {
                    CoreDataServices.shared.deleteAllNotes(in: "Note")
                }
                self.navigationController?.popViewController(animated: true)
            }
            let declineAction = UIAlertAction(title: "No", style: .default) {action in
                
            }
            AlertHelper().showAlert(title: "Delete", message: "Do you want to delete all notes?", style: .alert, prexentingView: self, actions: [acceptAction, declineAction])
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SettingsCell else {
            return UITableViewCell()
        }
        
        let setting = settings[indexPath.row]
        cell.settingsImage.image = setting.settingsImage
        cell.title.text = setting.title
        cell.button.setTitle(setting.buttonTitle, for: .normal)
        cell.delegate = self

        
        switch indexPath.row {
        case 0:
            cell.cellType(settingsType: .withRightButton)
        case 1:
            cell.cellType(settingsType: .withSwitch)
        case 2:
            cell.cellType(settingsType: .none)
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50.0
    }
}
extension SettingsView: SettingsCellDelegate {
    
    
    func switchButtonChanged(isOn: Bool) {
        if isOn {
            UserDefaults.standard.set(isOn, forKey: "Theme")
            overrideUserInterfaceStyle = .dark
            
        }
        else{
            UserDefaults.standard.set(isOn, forKey: "Theme")
            overrideUserInterfaceStyle = .light
            
        }
        
    }
}



