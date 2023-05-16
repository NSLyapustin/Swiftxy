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
        let breakpointManagedObject = NSEntityDescription.insertNewObject(
            forEntityName: "BreakpointRule",
            into: self.managedObjectContext!)
        as! BreakpointRuleManagedObject

        breakpointManagedObject.id = UUID()
        breakpointManagedObject.ruleName = breakpoint.name
        breakpointManagedObject.ruleTemplate = breakpoint.template
        breakpointManagedObject.requestBody = breakpoint.requestBody
        breakpointManagedObject.responseBody = breakpoint.responseBody

        try managedObjectContext?.save()
    }

//    swiftxy://?name=testName&template=testTemplate&requestBody=testReqBody&responseBody=testRespBody

    public func update(_ breakpoint: BreakpointRule) throws {
        let fetchRequest = BreakpointRuleManagedObject.fetchRequest()

        fetchRequest.predicate = NSPredicate(
            format: "%K == %@", "id", breakpoint.id! as CVarArg
        )

        let context = persistentContainer!.viewContext

        let objects = try context.fetch(fetchRequest)

        let object = objects.first!

        object.ruleName = breakpoint.name
        object.ruleTemplate = breakpoint.template
        object.requestBody = breakpoint.requestBody
        object.responseBody = breakpoint.responseBody

        try context.save()
    }

    public func fetchBreakpoints() throws -> [BreakpointRule] {
        let fetchRequest = BreakpointRuleManagedObject.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]

        // Get a reference to a NSManagedObjectContext
        let context = persistentContainer!.viewContext

        // Fetch all objects of one Entity type
        let objects = try context.fetch(fetchRequest)

        return objects.map { BreakpointRule(id: $0.id, name: $0.ruleName, template: $0.ruleTemplate, requestBody: $0.requestBody, responseBody: $0.responseBody) }
    }

    public func delete(at index: Int) throws {
        let fetchRequest = BreakpointRuleManagedObject.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        // 03044EE1-E905-4846-935B-C5E3F7E85665
        // Get a reference to a NSManagedObjectContext
        let context = persistentContainer!.viewContext

        // Fetch all objects of one Entity type
        let objects = try context.fetch(fetchRequest)

        context.delete(objects[index])

        try context.save()
    }
}
