//
//  Note+CoreDataProperties.swift
//  NoteApp
//
//  Created by Tatina Dzhakypbekova on 6/5/24.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var date: Date?
    @NSManaged public var color: String?


}

 
