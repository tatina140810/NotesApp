//
//  CoreDataServices.swift
//  NoteApp
//
//  Created by Tatina Dzhakypbekova on 6/5/24.
//

import CoreData
import UIKit

class CoreDataServices {
    static let shared = CoreDataServices()
    private init() {
        
    }
    private var appDelegat: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    private var context: NSManagedObjectContext {
        appDelegat.persistentContainer.viewContext
    }
    func addNote(id: String, title: String, description: String, date: Date, color: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context) else {
            return
        }
        
        let note = Note(entity: entity, insertInto: context)
        note.id = id
        note.title = title
        note.desc = description
        note.date = date
        note.color = color
        
        
        appDelegat.saveContext()
    }
    
    func fetchNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            return try context.fetch(fetchRequest) as! [Note]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    func updateNotes(id: String,  title: String, description: String, date: Date) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try context.fetch(fetchRequest) as? [Note], let note = notes.first(where: { note in
                note.id == id}) else {
                return
            }
            note.title = title
            note.desc = description
            note.date = date
           
            
        }catch { print(error.localizedDescription)
            
        }
        appDelegat.saveContext()
    }
    func delete(id: String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try context.fetch(fetchRequest) as? [Note], let note = notes.first(where: { note in
                note.id == id}) else {
                return
            }
            context.delete(note)
            
        }catch { print(error.localizedDescription)
            
        }
        appDelegat.saveContext()
    }
    func deleteAllNotes(in entity : String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try context.fetch(fetchRequest) as? [Note]
            
            else {
                return
            } 
            notes.forEach { note in
                context.delete(note)
            }
            
        }
        catch { print(error.localizedDescription)
            
        }
        appDelegat.saveContext()
    }
}
