import Foundation
import UIKit
import SnapKit

class LanguageCell: UITableViewCell {
   
    
    let languageTitle: UILabel = {
        let label = UILabel()
        label.text = "Язык"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    let language: UILabel = {
        let label = UILabel()
        label.text = "Язык"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellConstraints()
        setupCell()
    }
    
    func cellConstraints() {
        addSubview(languageTitle)
        languageTitle.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(20)
        }
        addSubview(language)
        language.snp.makeConstraints{ make in
            make.top.equalTo(languageTitle.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
        }
        
    }
    private func setupCell() {
        
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

