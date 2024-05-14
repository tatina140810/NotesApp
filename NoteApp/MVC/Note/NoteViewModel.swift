import Foundation
import UIKit

protocol NoteViewModelProtocol: AnyObject {
    func saveNote(title: String, description: String, note: Note)
}

class NoteViewModel: NoteViewModelProtocol {
    
    private let coreDataService = CoreDataServices.shared
    
    weak var controller: NoteViewControllerProtocol?
   
    init(controller: NoteViewControllerProtocol) {
        self.controller = controller
    }
    
    
    func saveNote(title: String, description: String, note: Note) {
        guard let id = note.id, let color = note.color else {return}
               let date = Date()
               coreDataService.addNote(id: id, title: title, description: description, date: date, color: color)
    }
   
}

