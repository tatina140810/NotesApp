import UIKit

protocol HomeModelProtocol: AnyObject {
    func getNotes()
    
}

class HomeModel {
    weak var controller: HomeControllerProtocol?
       
       private let coreDataService = CoreDataServices.shared
       
       private var notes: [Note] = []
       
       init(controller: HomeControllerProtocol) {
           self.controller = controller
       }
       
}
extension HomeModel: HomeModelProtocol {
    func getNotes() {
        notes = coreDataService.fetchNotes()
        controller?.onSuccessNotes(notes: notes)
    }
}



