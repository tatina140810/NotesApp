//
//  CoreDataServices.swift
//  NoteApp
//
//  Created by Tatina Dzhakypbekova on 6/5/24.
//

import CoreData
import UIKit

enum CoreDataResponse{
    case success
    case failur
}
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
    func addNote(id: String, title: String, description: String, date: Date, color: String, completionHandler: @escaping (CoreDataResponse) -> ()) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context) else {
            DispatchQueue.main.async {
                completionHandler(.failur)
            }
            return
        }
        
        let note = Note(entity: entity, insertInto: context)
        note.id = id
        note.title = title
        note.desc = description
        note.date = date
        note.color = color
        
        
        appDelegat.saveContext()
        DispatchQueue.main.async {
            completionHandler(.success)
        }
    }
    
    func fetchNotes(completionHandler: @escaping (CoreDataResponse) -> ()) -> [Note] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            completionHandler(.success)
            
            return try context.fetch(fetchRequest) as! [Note]
        } catch {
            completionHandler(.failur)
            print(error.localizedDescription)
        }
        return []
    }
    
    func updateNotes(id: String,  title: String, description: String, date: Date, completionHandler: @escaping (CoreDataResponse) -> ()) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            completionHandler(.success)
            guard let notes = try context.fetch(fetchRequest) as? [Note], let note = notes.first(where: { note in
                note.id == id})  else {
                return
            }
            note.title = title
            note.desc = description
            note.date = date
           
            
        }catch { 
            completionHandler(.failur)
            print(error.localizedDescription)
            
        }
        appDelegat.saveContext()
        
    }
    func delete(id: String, completionHandler: @escaping (CoreDataResponse) -> ()){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try context.fetch(fetchRequest) as? [Note], let note = notes.first(where: { note in
                note.id == id}) else { 
                DispatchQueue.main.async {
                    completionHandler(.failur)
                }
                return
            }
            context.delete(note)
            
        }catch { 
            completionHandler(.failur)
            print(error.localizedDescription)
            
        }
        appDelegat.saveContext()
        DispatchQueue.main.async {
            completionHandler(.success)
        }
    }
    func deleteAllNotes(in entity : String, completionHandler: @escaping (CoreDataResponse) -> ()) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try context.fetch(fetchRequest) as? [Note]
            
            else {
                DispatchQueue.main.async {
                    completionHandler(.failur)
                }
                return
            } 
            notes.forEach { note in
                context.delete(note)
            }
            
        }
        catch { 
            completionHandler(.failur)
            print(error.localizedDescription)
            
        }
        appDelegat.saveContext()
        DispatchQueue.main.async {
            completionHandler(.success)
        }
    }
}
