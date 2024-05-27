
import UIKit
import SnapKit
protocol NoteViewProtocol: AnyObject {
    func saveData(title: String, description: String, note: Note)
    func failurNotes()
    func successNotes()
}

class NoteView: UIViewController {
    
    var note: Note?
    
    private var controller: NoteViewControllerProtocol?
    
    private let coreDataService = CoreDataServices.shared
    
    
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
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        label.text = dateString
        label.numberOfLines = 0
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
                
        return label
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Обновить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .red
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraints()
        setupData()
        navigationControllerSettings()
        controller = NoteViewController(view: self)
        updateTheme()
    }
    
    init(note: Note) {
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
        view.addSubview(copyButton)
        copyButton.snp.makeConstraints{make in
            make.bottom.equalTo(descriptionTextView.snp.bottom).inset(-5)
            make.trailing.equalTo(descriptionTextView.snp.trailing).inset(-5)
            make.height.equalTo(80)
            make.width.equalTo(70)
        }
        
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(updateButton)
        updateButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.width.equalTo(100)
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
    private func setupData() {
        guard let note = note else { return }
        textField.text = note.title
        descriptionTextView.text = note.desc
    }
    
    private func navigationControllerSettings() {
        navigationItem.title = "Редактировать"
        
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteButtonTapped))
        settingsButton.tintColor = .black
        
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    @objc private func updateButtonTapped() {
       
        AlertHelper().showAlert(title: "Сохранить", message: "Вы хоите сохранить заметку?", style: .alert, prexentingView: self) {action in
            if action == .action1 {
                self.controller?.setData(title: self.textField.text ?? "", description: self.descriptionTextView.text ?? "", note: self.note!)
                self.navigationController?.popViewController(animated: true)
                
            } else if action == .action2 {
                
            }
            
        }
    }
    
    
    @objc private func deleteButtonTapped() {
        guard let note = note, let id = note.id  else {return}
        
        AlertHelper().showAlert(title: "Удаление", message: "Вы хотите удалить заметку?", style: .alert, prexentingView: self) {action in
            if action == .action1 {
                
                self.coreDataService.delete(id: id) {response in
                    if response == .failur {
                        AlertHelper().showAlert(title: "Ошибка ", message: "Удалить заметку не удалось", style: .alert, prexentingView: self) {action in
                            if action == .action1 {
                            }
                            else if action == .action2 {
                                
                            }
                            
                        }
                    } else {
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                }
            } else if action == .action2 {
                
            }
        }
    }
}

extension NoteView: NoteViewProtocol {
    func successNotes() {
        navigationController?.popViewController(animated: true)
    }
    
    func failurNotes() {
        AlertHelper().showAlertWithOneAction(title: "Ошибка", message: "Обновление не удалось", style: .alert, prexentingView: self){action in
        }
            
    }
    
    func saveData(title: String, description: String, note: Note){
      
        
    }

}
    

