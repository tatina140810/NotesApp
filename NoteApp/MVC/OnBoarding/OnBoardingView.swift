import UIKit
import SnapKit

class OnBoardingView: UIViewController {
    var currentRow = 0
    
    private var onBoardingList: [OnBoard] = [OnBoard(image: UIImage(resource: .im1), title: "Welcom to The Notes", description: "Welcom to the notes - your new companion to tasks, goals, health - all in on place. Let's get started."), OnBoard(image: UIImage(resource: .im2), title: "Set Up Your profile", description: "Now that you're with us, let's get to now each other better. Fill out your profile, share your interests, and set your goals."), OnBoard(image: UIImage(resource: .im3), title: "Dive into The Notes", description: "You're fully equiped to dive into the world og the Notes. remember, we are here to assist you to every stap of the way. Ready to start? Let's go!")]
    
    private lazy var onBoardingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(OnBoardingCell.self, forCellWithReuseIdentifier: OnBoardingCell.reuseID)
        view.dataSource = self
        view.delegate = self
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    private lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        view.numberOfPages = 3
        view.currentPage = 0
        view.currentPageIndicatorTintColor = .black
        view.pageIndicatorTintColor = .lightGray
        
        return view
    }()
    
    private lazy var skipButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Пропустиь", for: .normal)
        view.tintColor = .red
        view.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Дальше", for: .normal)
        view.backgroundColor = .red
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.tintColor = .white
        view.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraints()
//        UserDefaults.standard.removeObject(forKey: "isOnBoardShown")
    }
    
    func setupConstraints() {
        view.addSubview(onBoardingCollectionView)
        onBoardingCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(190)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-130)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
            make.height.equalTo(42)
        }
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-130)
            make.leading.equalTo(view.snp.centerX).offset(-10)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(42)
        }
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints{ make in
            make.bottom.equalTo(nextButton.snp.top).offset(-40)
            make.centerX.equalToSuperview()}
        
    }
    @objc func nextButtonTapped() {
        if currentRow < onBoardingList.count - 1 {
            currentRow += 1
            scrollToPage(currentRow)
        } else {
            skipButtonTapped()
        }
    }
    
    func scrollToPage(_ page: Int) {
        onBoardingCollectionView.isPagingEnabled = false
        onBoardingCollectionView.scrollToItem(at: IndexPath(row: page, section: 0), at: .centeredHorizontally, animated: true)
        onBoardingCollectionView.isPagingEnabled = true
    }
    
    @objc func skipButtonTapped() {
        let vc = HomeView()
        navigationController?.pushViewController(vc, animated: true)
        UserDefaults.standard.bool(forKey: "isOnBoardShown")
    }
}

extension OnBoardingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onBoardingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCell.reuseID, for: indexPath) as! OnBoardingCell
        cell.setupOnBoard(onBoard: onBoardingList[indexPath.item])
        return cell
    }
}

extension OnBoardingView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x / scrollView.bounds.width
        if !pageIndex.isInfinite && !pageIndex.isNaN {
            pageControl.currentPage = Int(round(pageIndex))
        }
    }
}
