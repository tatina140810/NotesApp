import UIKit
import CoreData
import SnapKit

protocol HomeViewProtocol: AnyObject {
    func successNotes(notes: [Note])
    
}

class HomeView: UIViewController {
    
    private var controller: HomeControllerProtocol?
    
    private var notes: [Note] = []
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .red
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(NotesCell.self, forCellWithReuseIdentifier: NotesCell.reuseId)
        view.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        controller = HomeController(view: self)
        navigationControllerSettings()
        setupConstreints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        controller?.onGetNotes()
        
    }
    
    private func navigationControllerSettings() {
        navigationItem.title = "Title"
        
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        settingsButton.tintColor = .black
        
        navigationItem.rightBarButtonItem = settingsButton
    }
    private func setupConstreints() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(notesCollectionView)
        notesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.left.right.bottom.equalToSuperview()
        }
        view.addSubview(plusButton)
        plusButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
    }
  
    @objc func settingsButtonTapped() {
        
        let vc = SettingsView()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func plusButtonTapped() {
        
        let addNoteView = AddNoteView()
        navigationController?.pushViewController(addNoteView, animated: true)
    }
}

extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotesCell.reuseId, for: indexPath) as! NotesCell
        
        cell.fill(note: notes[indexPath.row])
        cell.indexPath = indexPath
       
        
        return cell
    }
    
}
extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 60) / 2, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     let note = notes[indexPath.row]
        let vc = NoteView(note: note)

        navigationController?.pushViewController(vc, animated: true)
    }
}
extension HomeView: HomeViewProtocol {
    func successNotes(notes: [Note]) {
        self.notes = notes
        notesCollectionView.reloadData()
    }
}
