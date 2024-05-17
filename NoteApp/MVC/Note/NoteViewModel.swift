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
        guard let id = note.id else {return}
        let date = Date()
        
        coreDataService.updateNotes(id: id, title: title, description: description, date: date) {response in
            if response == .failur {
                self.controller?.onFailurNotes()
    
            }else {
                self.controller?.onSuccessNotes()
            }
            
        }
    }
   
}

