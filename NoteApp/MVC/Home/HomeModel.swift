import UIKit

protocol HomeModelProtocol: AnyObject {
    
}

struct NotesModel {
    var notesImage: UIImage
    var notesName: String
}

class HomeModel {
    var controller: HomeModelProtocol?
    
    var notes: [NotesModel] = []
    
    init(controller: HomeModelProtocol) {
        self.controller = controller
    }
}

extension HomeModel: HomeModelProtocol {
    
}

struct NotesData {
    let notes: [NotesModel] = [
        NotesModel(notesImage: UIImage(named: "img4.png")!, notesName: "School notes"),
        NotesModel(notesImage: UIImage(named: "img3.png")!, notesName: "Funny jokes"),
        NotesModel(notesImage: UIImage(named: "img2.png")!, notesName: "Travel bucket list"),
        NotesModel(notesImage: UIImage(named: "img1.png")!, notesName: "Random cook")
    ]
}


