import UIKit
import SnapKit


protocol AddNoteViewProtocol: AnyObject {
    func sucsessData(title: String, description: String)
    func saccessSave()
    func failurSave()
}

class AddNoteView: UIViewController {
    
    private var controller: AddNoteControllerProtocol?
    
    private lazy var textField: UITextField = {
        let view = UITextField()
        view.placeholder = "Название заметки"
        view.borderStyle = .roundedRect
        view.layer.cornerRadius = 22
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: view.frame.height))
                view.leftView = paddingView
                view.leftViewMode = .always
        return view
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let view = UITextView()
        view.layer.cornerRadius = 22
        view.clipsToBounds = true
        view.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return view
    }()
    private lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "rectangle.on.rectangle"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .red
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        controller = AddNoteController(view: self)
        setupConstraints()
        updateTheme()
    
    }
    private func setupConstraints() {
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(44)
        }
        view.addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(textField).offset(65)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(400)
            
        }
        view.addSubview(copyButton)
        copyButton.snp.makeConstraints{make in
            make.bottom.equalTo(descriptionTextView.snp.bottom).inset(-5)
            make.trailing.equalTo(descriptionTextView.snp.trailing).inset(-5)
            make.height.equalTo(80)
            make.width.equalTo(70)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.width.equalTo(120)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
    }
    private func updateTheme() {
            let isDarkTheme = UserDefaults.standard.bool(forKey: "Theme")
            view.overrideUserInterfaceStyle = isDarkTheme ? .dark : .light
            let textFieldBackgroundColor: UIColor = isDarkTheme ? UIColor(hex: "686D76") : UIColor(hex: "EEEEEF")
            let textFieldTextColor: UIColor = isDarkTheme ? .white : .black
            let descriptionTextViewBackgroundColor: UIColor = isDarkTheme ? UIColor(hex: "686D76") : UIColor(hex: "EEEEEF")
            let descriptionTextViewTextColor: UIColor = isDarkTheme ? .white : .black
            
            textField.backgroundColor = textFieldBackgroundColor
            textField.textColor = textFieldTextColor
            descriptionTextView.backgroundColor = descriptionTextViewBackgroundColor
            descriptionTextView.textColor = descriptionTextViewTextColor
        }
    @objc private func saveButtonTapped() {
       
        controller?.getData(title: textField.text ?? "", description: descriptionTextView.text ?? "")
        
    }
}
extension AddNoteView: AddNoteViewProtocol {
    
    
    func sucsessData(title: String, description: String) {
        
    }
    func saccessSave() {
        navigationController?.popViewController(animated: true)
    }
    
    func failurSave() {
        
        AlertHelper().showAlertWithOneAction(title: "Ошибка", message: "Сохранить заметку не удалось", style: .alert, prexentingView: self) {action in
        }
    }
    
}
    

