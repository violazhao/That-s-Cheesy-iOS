//
//  RecipeFullViewModel.swift
//  That's Cheesy
//
//  Created by Viola Zhao on 2/13/23.
//

import Foundation
import CoreData

struct RecipeFullViewModel {
    var id: NSManagedObjectID?
    var recipeName: String
    var image: String?
    var ingredients: String
    var instructions: String
    var notes: String?
    var saved: Bool?
}
