import UIKit
import SnapKit

protocol HomeViewProtocol: AnyObject {
    func successNotes(notes: [NotesModel])
    
}

class HomeView: UIViewController {
    private var controller: HomeControllerProtocol?
    
    private var notes: [NotesModel] = []
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private lazy var notesLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .red
        button.layer.cornerRadius = 25
        return button
    }()
    
    private var collectionView: UICollectionView!
    private var layout = UICollectionViewFlowLayout()
    private var cellidentifier = "Cell"
    private var itemsPerRow: CGFloat = 2
    
    
    private lazy var notesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NotesCell.self, forCellWithReuseIdentifier: cellidentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        controller = HomeController(view: self)
        controller?.onGetNotes()
        navigationControllerSettings()
        setuoConstreints()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 3
    }
    
    private func navigationControllerSettings() {
        navigationItem.title = "Title"
        
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        settingsButton.tintColor = .black
        
        navigationItem.rightBarButtonItem = settingsButton
    }
    private func setuoConstreints() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        view.addSubview(notesLabel)
        notesLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(30)
        }
        view.addSubview(plusButton)
        plusButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-120)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        view.addSubview(notesCollectionView)
        notesCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(notesLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(240)}
        
    }
    
   
    
    @objc func settingsButtonTapped() {
        let vc = SettingsView()
       navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeView: HomeViewProtocol{
    
    func successNotes(notes: [NotesModel]) {
        self.notes = notes
        notesCollectionView.reloadData()
    }
    
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var cellData: [NotesModel] {
        return notes
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellidentifier, for: indexPath) as! NotesCell
        
        cell.imageView.image = cellData[indexPath.item].notesImage
        cell.titleLabel.text = cellData[indexPath.item].notesName
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: ((collectionView.bounds.width)-10)/2, height: 110)
    }
    
}

