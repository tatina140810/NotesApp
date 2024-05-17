protocol HomeControllerProtocol: AnyObject {
    func onGetNotes()
    func onSuccessNotes(notes: [Note])
    func onFailurNotes()
    func onSearchNote(title: String)
    
}
class HomeController {
    
    
    weak var view: HomeViewProtocol?
    var model: HomeModelProtocol?
    
    init(view: HomeViewProtocol?) {
        self.view = view
        self.model = HomeModel(controller: self) 
    }
    
}
extension HomeController: HomeControllerProtocol {
    func onSearchNote(title: String) {
        model?.searchNote(title: title)
    }
    
    
    func onSuccessNotes(notes: [Note]) {
        view?.successNotes(notes: notes)
    }
    
    func onGetNotes() {
        model?.getNotes()
    }
    func onFailurNotes() {
        view?.feilurNotes()
    }
    
}


    
    
    


