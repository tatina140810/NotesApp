import UIKit

protocol HomeModelProtocol: AnyObject {
    func getNotes()
    func searchNote(title:String)
    
}

class HomeModel {
    weak var controller: HomeControllerProtocol?
    
    private let coreDataService = CoreDataServices.shared
    
    private var notes: [Note] = []
    private var filteredNotes: [Note] = []
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
}
extension HomeModel: HomeModelProtocol {
    func searchNote(title:String) {
        filteredNotes = []
        let searchTitle = title.lowercased()
        
        if searchTitle.isEmpty == true {
            filteredNotes = notes
            controller?.onSuccessNotes(notes: notes)
        } else {
            filteredNotes = notes.filter({ note in
                note.title?.lowercased().contains(title.lowercased()) == true
            })
            controller?.onSuccessNotes(notes: filteredNotes)
        }
    }
    
    func getNotes() {
        notes = coreDataService.fetchNotes { responce in
            if responce == .failur {
                self.controller?.onFailurNotes()
                
            }
        }
        controller?.onSuccessNotes(notes:notes)
        
    }
}




