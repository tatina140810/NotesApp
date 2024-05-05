import Foundation
import UIKit
import SnapKit

protocol TableCellDelegate: AnyObject {
    
    func switchButtonChanged(isOn: Bool)
}

class TableCell: UITableViewCell {
    
    var delegate: TableCellDelegate?
    
    let settingsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "network")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Язык"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("русский", for: .normal)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        button.semanticContentAttribute = .forceRightToLeft
        button.contentHorizontalAlignment = .leading
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: -10)
        return button
    }()
    
    let switchButton: UISwitch = {
        let view = UISwitch()
        view.isOn = UserDefaults.standard.bool(forKey: "Theme")
        return view
    }()
    private func setupSwitch() {
        switchButton.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        
    }
    @objc func switchValueChanged(_ sender: UISwitch) {
        delegate?.switchButtonChanged(isOn: sender.isOn)
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellConstraints()
        setupCell()
        setupSwitch()
    }
    
    func cellConstraints() {
        addSubview(settingsImage)
        settingsImage.snp.makeConstraints {make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
        }
        addSubview(title)
        title.snp.makeConstraints {make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(settingsImage).offset(40)
        }
        addSubview(button)
        button.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
        
        contentView.addSubview(switchButton)
        switchButton.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)}
        
    }
    var settingsType: SettingsType = .none {
        didSet {
            updateCell()
        }
    }
    
    private func updateCell() {
        switch settingsType {
        case .none:
            button.isHidden = true
            switchButton.isHidden = true
        case .withRightButton:
            switchButton.isHidden = true
        case .withSwitch:
            button.isHidden = true
        }
    }
    
    func cellType(settingsType: SettingsType) {
        self.settingsType = settingsType
    }
    private func setupCell() {
        
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

