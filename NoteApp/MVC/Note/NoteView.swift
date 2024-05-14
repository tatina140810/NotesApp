
import UIKit
import SnapKit
protocol NoteViewProtocol: AnyObject {
    func saveData(title: String, description: String, note: Note)

}

class NoteView: UIViewController {
    
    var note: Note?
    
    private var controller: NoteViewControllerProtocol?
    
    private let coreDataService = CoreDataServices.shared
    
    private lazy var textField: UITextField = {
        let view = UITextField()
        view.placeholder = "Add Note Title"
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
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .red
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraints()
        setupData()
        navigationControllerSettings()
        controller = NoteViewController(view: self)
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
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.width.equalTo(100)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupData() {
        guard let note = note else { return }
        textField.text = note.title
        descriptionTextView.text = note.desc
    }
    
    private func navigationControllerSettings() {
        navigationItem.title = "Title"
        
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteButtonTapped))
        settingsButton.tintColor = .black
        
        navigationItem.rightBarButtonItem = settingsButton
    }
   
    @objc private func saveButtonTapped() {
        controller?.setData(title: textField.text ?? "", description: descriptionTextView.text ?? "", note: note!)
       
               let vc = HomeView()
               navigationController?.pushViewController(vc, animated: true)
           }
           
        
        
    @objc private func deleteButtonTapped() {
        guard let note = note, let id = note.id  else {return}
                     let allertController = UIAlertController(title: "Delete", message: "Do you want to delete note?", preferredStyle: .alert)
                     let acceptAction = UIAlertAction(title: "Yes", style: .cancel) {action in
                         self.coreDataService.delete(id: id)
                         self.navigationController?.popViewController(animated: true)
                     }
                     let declineAction = UIAlertAction(title: "No", style: .default) {action in
             
                     }
                     allertController.addAction(acceptAction)
                     allertController.addAction(declineAction)
                     present(allertController, animated: true)
             
    }
}

extension NoteView: NoteViewProtocol {
    func saveData(title: String, description: String, note: Note){
      
        
    }

}
    

