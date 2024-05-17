import Foundation

protocol AddNoteControllerProtocol: AnyObject {
    func getData(title: String, description: String)
    func onSaccessSave()
    func onFailurSave()
}
func onSuccessAddNote(title: String, description: String){
    
}

class AddNoteController: AddNoteControllerProtocol {
    
    
    weak var view: AddNoteViewProtocol?
    var model: AddNoteModelProtocol?
    
    init(view: AddNoteViewProtocol) {
        self.view = view
        self.model = AddNoteModel(controller: self)
    }
    
    func getData(title: String, description: String) {
        model?.saveNote(title: title, description: description)
    }
    func onSuccessAddNote(title: String, description: String){
        view?.sucsessData(title: title, description:  description)
    }
    func onSaccessSave() {
        view?.saccessSave()
    }
    
    func onFailurSave() {
        view?.failurSave()
    }

}

