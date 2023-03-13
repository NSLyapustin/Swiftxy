//
//  NSManagedObjectContext.swift
//  Swiftxy
//
//  Created by n.lyapustin on 12.03.2023.
//

import CoreData
import Foundation

class CoreDataStorage {
    private lazy var persistentContainer: NSPersistentContainer? = {
        let modelURL = Bundle(for: type(of: self)).url(forResource: "Swiftxy", withExtension: "momd")

        var container: NSPersistentContainer

        guard let model = modelURL.flatMap(NSManagedObjectModel.init) else {
            print("Fail to load the trigger model!")
            return nil
        }

        container = NSPersistentContainer(name: "Your model file name", managedObjectModel: model)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })

        return container
    }()

    private var managedObjectContext: NSManagedObjectContext?

    public init?() {
        managedObjectContext = persistentContainer?.viewContext

        guard managedObjectContext != nil else {
            print("Cann't get right managed object context.")
            return nil
        }
    }

    public func save(_ breakpoint: BreakpointRule) throws {
        let entity = NSEntityDescription.entity(forEntityName: "BreakpointRule", in: managedObjectContext!)
        let breakpointManagedObject = NSManagedObject(entity: entity!, insertInto: managedObjectContext)

        managedObjectContext?.setValue(breakpoint.template, forKeyPath: "ruleTemplate")
        managedObjectContext?.setValue(breakpoint.name, forKeyPath: "ruleName")

        try managedObjectContext?.save()
    }

    public func fetchBreakpoints() throws -> [BreakpointRule] {
        let fetchRequest = BreakpointRuleManagedObject.fetchRequest()

        // Get a reference to a NSManagedObjectContext
        let context = persistentContainer!.viewContext

        // Fetch all objects of one Entity type
        let objects = try context.fetch(fetchRequest)

        return objects.map { BreakpointRule(name: $0.ruleName, template: $0.ruleTemplate) }
    }
}
