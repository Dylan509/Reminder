//
//  Person+CoreDataProperties.swift
//  Reminder
//
//  Created by lim jia le on 2021/9/13.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var phoneNo: String?
    @NSManaged public var birthday: Date?
    @NSManaged public var name: String?
    

}

extension Person : Identifiable {

}
