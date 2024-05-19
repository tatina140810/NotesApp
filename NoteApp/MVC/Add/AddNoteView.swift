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
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.black.cgColor
        return view
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
            make.height.equalTo(200)
        }
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.width.equalTo(120)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
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
    

