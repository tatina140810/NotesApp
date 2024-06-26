import UIKit
import SnapKit
protocol SettingsViewProtocol: AnyObject {
    func sucsessSettings(settings: [Settings])
    func successNotes()
    func failurNotes()
    
}

class SettingsView: UIViewController, LanguageViewDelegate {
    func didLanguageSelect() {
        setupLocalizedText()
    }
    
    private var controller: SettingsControllerProtocol?
    
    private var settings: [Settings] = []
    
    private var notes: [Note] = []
    
    
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
        setupLocalizedText()
        updateTheme()
        
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
    private func setupLocalizedText(){
        navigationItem.title = "Настройки".localised()
        navigationItem.leftBarButtonItem?.title = "назад".localised()
        
    }
    private func updateTheme() {
           let isDarkTheme = UserDefaults.standard.bool(forKey: "Theme")
           view.overrideUserInterfaceStyle = isDarkTheme ? .dark : .light
           let tintColor: UIColor = isDarkTheme ? .white : .black
           navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor]
           navigationItem.rightBarButtonItem?.tintColor = tintColor
       }
    
    private func navigationControllerSettings() {
        
        let backButton = UIBarButtonItem(title: "назад", style: .plain , target: self, action: #selector(backButtonTapped))
        
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        
    }
    
}
extension SettingsView: SettingsViewProtocol{
    
    
    func sucsessSettings(settings: [Settings]){
        self.settings = settings
        tableView.reloadData()
        
    }
    func successNotes() {
        self.notes = []
    }
    
    func failurNotes() {
        AlertHelper().showAlertWithOneAction(title: "Ошибка", message: "Удаление заметок не удалось", style: .alert, prexentingView: self) { action in
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension SettingsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let languageView = LanguageSettingsView()
            languageView.delegate = self
            navigationController?.pushViewController(languageView, animated: true)
        }
        if indexPath.row == 2 {
            
            AlertHelper().showAlert(title: "Удаление", message: "Вы хотите удалить все заметки?", style: .alert, prexentingView: self) { action in
                if action == .action1 {
                    self.controller?.onDeleteAllNotes(notes: self.notes)
                    self.navigationController?.popViewController(animated: true)
                    
                } else if action == .action2 {
                    
                }
                
            }
            self.navigationController?.popViewController(animated: true)
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
                UserDefaults.standard.set(isOn, forKey: "Theme")
                updateTheme()
            }
        
    }




