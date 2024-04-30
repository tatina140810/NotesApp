import UIKit

protocol HomeModelProtocol: AnyObject {
    func getNotes()
    
}

struct NotesModel {
    var notesImage: UIImage
    var notesName: String
}

class HomeModel {
    weak var controller: HomeControllerProtocol?
    
    var notes: [NotesModel] = [
        NotesModel(notesImage: UIImage(named: "img4.png")!, notesName: "School notes"),
        NotesModel(notesImage: UIImage(named: "img3.png")!, notesName: "Funny jokes"),
        NotesModel(notesImage: UIImage(named: "img2.png")!, notesName: "Travel bucket list"),
        NotesModel(notesImage: UIImage(named: "img1.png")!, notesName: "Random cook")
    ]
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
}
extension HomeModel: HomeModelProtocol {
    
    func getNotes() {
        controller?.onSuccessNotes(notes: notes) }
    
    
}



