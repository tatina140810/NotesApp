
import UIKit
import SnapKit

protocol NoteCellDelegate: AnyObject {
    func likeButtonDidTap(index: Int)
}

class NotesCell: UICollectionViewCell {
    static let reuseId = "note_cell"
    
    var indexPath: IndexPath?
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellConstraints()
        
       layer.cornerRadius = 10
    }
    
    func cellConstraints() {
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(20)
        }
        
    }
    func fill(note: Note) {
        titleLabel.text = note.title
        switch note.color{
        case "FD6F96":
            backgroundColor = UIColor(hex:"FD6F96")
        case "FFEBA1":
            backgroundColor = UIColor(hex: "FFEBA1")
        case "95DAC1":
            backgroundColor = UIColor(hex: "95DAC1")
        case "6F69AC":
            backgroundColor = UIColor(hex: "6F69AC")
        default:
            backgroundColor = .clear
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
