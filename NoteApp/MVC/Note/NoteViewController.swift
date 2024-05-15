import Foundation
import UIKit

protocol NoteViewControllerProtocol: AnyObject {
    func onSaveData (title: String, description: String, note: Note)
    
    func setData(title: String, description: String, note: Note)
}


class NoteViewController: NoteViewControllerProtocol {
    
    weak var view: NoteViewProtocol?
    var model: NoteViewModelProtocol?
    
    
    init(view: NoteViewProtocol) {
        self.view = view
        self.model = NoteViewModel(controller: self)
    }
    
    func onSaveData (title: String, description: String, note: Note){
        view?.saveData(title: title, description: description, note: note)
    }

    func setData(title: String, description: String, note: Note) {
        model?.saveNote(title: title, description: description, note: note)
    }
   
        
}
