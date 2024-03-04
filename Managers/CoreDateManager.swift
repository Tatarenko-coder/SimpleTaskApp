//
//  CoreDateManager.swift
//  SimpleTaskApp
//
//  Created by TD on 04.03.2024.
//

import Foundation
import CoreData


class CoreDateManager {
    
    static let shared: CoreDateManager = CoreDateManager()
    
    let persistentContainer: NSPersistentContainer
    
    var content: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        self.persistentContainer = NSPersistentContainer(name: "SimpleTaskApp")
        persistentContainer.loadPersistentStores { description, error in
            if let error  = error {
                fatalError("Sorry unable to intialize Core Data \(error)")
            }
        }
    }
    
    func save() {
        do {
            try content.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveNewTask(title: String, descriptionTask: String) {
        let task = Task(context: content)
        task.title = title
        task.descriptionTask = descriptionTask
        save()
    }
    
    func updateTask(_ task: Task, title: String, descriptionTask: String, inProgress: Bool) {
        task.title = title
        task.descriptionTask = descriptionTask
        task.inProgress = inProgress
        save()
    }
    
    func toggleToCompleted(_ task: Task) {
        task.inProgress = !task.inProgress
        save()
    }
    
    func deleteTask(_ task: Task) {
        content.delete(task)
        save()
    }
}
