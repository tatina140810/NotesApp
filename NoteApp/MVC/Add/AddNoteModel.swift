import Foundation
import UIKit

protocol AddNoteModelProtocol: AnyObject {
    func saveNote(title: String, description: String)
}

class AddNoteModel: AddNoteModelProtocol {
    
    private let coreDataService = CoreDataServices.shared
    
    weak var controller: AddNoteControllerProtocol?
   
    init(controller: AddNoteControllerProtocol) {
        self.controller = controller
    }
    
    private let colors: [UIColor] = [
        UIColor(hex: "FD6F96"),
        UIColor(hex: "FFEBA1"),
        UIColor(hex: "95DAC1"),
        UIColor(hex: "6F69AC")
    ]
    
    func saveNote(title: String, description: String) {
        let id = UUID().uuidString
        let date = Date()
        let color = generateColor()
        coreDataService.addNote(id: id, title: title, description: description, date: date, color: color)
    }
    
    private func generateColor() -> String {
        guard let color = colors.randomElement() else { return "" }
        
        switch color {
        case UIColor(hex: "FD6F96"): return "FD6F96"
        case UIColor(hex: "FFEBA1"): return "FFEBA1"
        case UIColor(hex: "95DAC1"): return "95DAC1"
        case UIColor(hex: "6F69AC"): return "6F69AC"
        default: return ""
        }
    }
}

