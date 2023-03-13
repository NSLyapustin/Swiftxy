//
//  BreakpointRuleManagedObject+CoreDataProperties.swift
//  
//
//  Created by n.lyapustin on 12.03.2023.
//
//

import Foundation
import CoreData


extension BreakpointRuleManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BreakpointRuleManagedObject> {
        return NSFetchRequest<BreakpointRuleManagedObject>(entityName: "BreakpointRule")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var ruleName: String
    @NSManaged public var ruleTemplate: String

}
