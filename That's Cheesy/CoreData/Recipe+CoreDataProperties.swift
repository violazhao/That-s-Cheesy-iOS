//
//  Recipe+CoreDataProperties.swift
//  That's Cheesy
//
//  Created by Viola Zhao on 2/15/23.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var recipeName: String?
    @NSManaged public var image: String?
    @NSManaged public var instructions: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var notes: String?
    @NSManaged public var saved: Bool

}

extension Recipe : Identifiable {

}
