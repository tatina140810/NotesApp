//
//  OnBoardingCell.swift
//  NoteApp
//
//  Created by Tatina Dzhakypbekova on 5/5/24.
//

import UIKit
struct OnBoard {
    var image: UIImage
    var title: String
    var description: String
}

class OnBoardingCell: UICollectionViewCell {
    
    
    static let reuseID = "onBoardingCell"
    
    private lazy var onBoardingImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private lazy var onBoardingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "Welcome To The Note"
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var onBoardingDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = "jdhnvjfkvbkfjvnkv dkjvmkfvmkcm vkv dkjfmkldv,vnmvn"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupOnBoard (onBoard: OnBoard){
        onBoardingImage.image = onBoard.image
        onBoardingLabel.text = onBoard.title
        onBoardingDescriptionLabel.text = onBoard.description
        
    }
    func setupUI(){
        
        addSubview(onBoardingImage)
        onBoardingImage.snp.makeConstraints {make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(140)
            make.height.equalTo(210)
        }
        addSubview(onBoardingLabel)
        onBoardingLabel.snp.makeConstraints {make in
            make.centerX.equalToSuperview()
            make.top.equalTo(onBoardingImage.snp.bottom).offset(30)
        }
        addSubview(onBoardingDescriptionLabel)
        onBoardingDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(onBoardingLabel).offset(50)
            
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
    }
}
