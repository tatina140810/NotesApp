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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableCell.self, forCellReuseIdentifier: "cell")
      
        
        navigationControllerSettings()
        tableViewConstraints()
        
    }
    
    func tableViewConstraints() {
        view.addSubview(tableView)
           tableView.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(120)
               make.leading.equalToSuperview().offset(20)
               make.trailing.equalToSuperview().offset(-20)
               make.bottom.equalToSuperview()
           }
           
       }

    private func navigationControllerSettings() {
        navigationItem.title = "Settings"
        
        let label = UIBarButtonItem(title: "Label", style: .plain , target: self, action: #selector(labelButtonTapped))
      label.tintColor = .blue
        
        navigationItem.leftBarButtonItem = label
    }
    @objc func labelButtonTapped() {
        
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableCell else {
            return UITableViewCell()
        }
        cell.delegate = self 
        let setting = settings[indexPath.row]
        cell.settingsImage.image = setting.settingsImage
        cell.title.text = setting.title
        cell.button.setTitle(setting.buttonTitle, for: .normal)
        
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
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        // Установка цвета фона для заголовка (если он есть)
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = UIColor.blue // Любой цвет, который вам нужен
        }
    }

}
extension SettingsView: TableCellDelegate {
    func switchButtonChahged() {
        if self.traitCollection.userInterfaceStyle == .dark {
                } else {
                    overrideUserInterfaceStyle = .dark
                }
        setNeedsStatusBarAppearanceUpdate()
    }
        
}
    
    
