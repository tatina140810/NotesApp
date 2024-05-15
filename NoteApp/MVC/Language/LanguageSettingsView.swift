//
//  LanguageSettings.swift
//  NoteApp
//
//  Created by Tatina Dzhakypbekova on 15/5/24.
//

import UIKit
import SnapKit
protocol LanguageSettingsViewProtocol: AnyObject {
    func sucsessLanguage(language: [Language])
    
}

class LanguageSettingsView: UIViewController {
    private var controller: LanguageSettingsControllerProtocol?
    
    private var language: [Language] = []
    
    private var tableView: UITableView = {
        let view = UITableView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        controller = LanguageSettingsController(view: self)
        controller?.onGetLanguageSettings()
        tableViewSettings()
        
    }
    
    func tableViewSettings() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LanguageCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(195)
        }
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.pushViewController(SettingsView(), animated: true)
        
    }
    
}
extension LanguageSettingsView: LanguageSettingsViewProtocol{
    func sucsessLanguage(language: [Language]){
        self.language = language
//        tableView.reloadData()
        
    }
    
}
extension LanguageSettingsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return language.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LanguageCell else {
            return UITableViewCell()
        }
        
        let language = language[indexPath.row]
        cell.languageTitle.text = language.languageTitle
        cell.language.text = language.language

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 65.0
    }
    
}



