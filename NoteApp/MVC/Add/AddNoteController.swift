import Foundation

protocol AddNoteControllerProtocol: AnyObject {
    func getData(title: String, description: String)
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

}

