//
//  Recipe.swift
//  That's Cheesy
//
//  Created by Viola Zhao on 2/10/23.
//

import Foundation
import UIKit

class Recipe: Encodable, Decodable {
    var recipeName: String
    var image: String?
    var ingredients: String
    var instructions: String
    var notes: String?
    var saved: Bool?
    
    init(recipeName: String, image: String? = nil, ingredients: String, instructions: String, notes: String? = nil, saved: Bool? = false) {
        self.recipeName = recipeName
        self.image = image
        self.ingredients = ingredients
        self.instructions = instructions
        self.notes = notes
        self.saved = saved
    }
}
