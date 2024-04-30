protocol HomeControllerProtocol: AnyObject {
    func onGetNotes()
    func onSuccessNotes(notes: [NotesModel] )
    
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
    func onSuccessNotes(notes: [NotesModel]) {
        view?.successNotes(notes: notes)
    }
    
    func onGetNotes() {
        model?.getNotes()
    }
}
    
    
    


