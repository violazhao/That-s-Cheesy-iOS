//
//  RecipeManager.swift
//  That's Cheesy
//
//  Created by Viola Zhao on 2/10/23.
//

import Foundation
import UIKit

class RecipeManager {
    static let shared: RecipeManager = RecipeManager()
    var saved: [Recipe] = [Recipe]()
    var filtered: [Recipe] = [Recipe]()
    
    var recipes = [
        Recipe(recipeName: "Best Ever Cheesecake", image: "https://www.onceuponachef.com/images/2017/12/cheesecake-1200x1393.jpg", ingredients: "1 1/2 cups (128g) graham cracker crumbs, 9 to 10 whole graham crackers, crushed", instructions: "Mix together the room-temperature cream cheese and sugar until smooth", notes: "Delicious!", saved: false),
        Recipe(recipeName: "Baked Feta Pasta", image: "https://www.cookingclassy.com/wp-content/uploads/2021/07/baked-feta-pasta-3.jpg", ingredients: "10 oz. pasta", instructions: "Place feta into center of tomato mixture and drizzle with remaining 1 tablespoon oil", saved: true),
        Recipe(recipeName: "World's Best Lasagna", ingredients: "2 (6 ounce) cans tomato paste", instructions: "Preheat the oven to 375 degrees F (190 degrees C)", saved: false),
        Recipe(recipeName: "Grilled Cheese Sandwich", image: "https://natashaskitchen.com/wp-content/uploads/2021/08/Grilled-Cheese-Sandwich-SQ.jpg", ingredients: "2 slices 1/2 inch thick white bread", instructions: "Cook until second side is golden brown and cheese is melted", saved: true),
        Recipe(recipeName: "Ham and Cheese Chowder", image: "https://tmbidigitalassetsazure.blob.core.windows.net/rms3-prod/attachments/37/1200x1200/exps78310_SD163615D04_07_2b.jpg", ingredients: "2 cups cubed fully cooked ham", instructions: "In a Dutch oven, cook the bacon over medium heat until crisp", saved: false),
        Recipe(recipeName: "No Fuss Quiche", image: "https://www.cookingclassy.com/wp-content/uploads/2021/03/quiche-3.jpg", ingredients: "3 tbs butter, melted", instructions: "Fold in cheese and fillings.", saved: true),
        Recipe(recipeName: "World's Best Lasagna", image: "https://natashaskitchen.com/wp-content/uploads/2018/12/Lasagna-Recipe-5.jpg", ingredients: "1 pound sweet Italian sausage", instructions: "Bake in the preheated oven for 25 minutes", saved: true),
        Recipe(recipeName: "Easy Cheesy Potatoes", image: "https://tornadoughalli.com/wp-content/uploads/2018/08/Crockpot-Cheesy-Potatoes3-2.jpg", ingredients: "1 cup sour cream", instructions: "Toss in the potatoes (or frozen hash brown potatoes) and combine", saved: false),
        Recipe(recipeName: "Baked Mac and Cheese", image: "https://ameessavorydish.com/wp-content/uploads/2011/03/Baked-mac-and-cheese-feature.jpg", ingredients: "1 tbsp extra virgin olive oil", instructions: "Preheat oven to 350F. Lightly grease a large 3 qt or 4 qt baking dish.", saved: false),
        Recipe(recipeName: "Cheesy Korean Garlic Bread", image: "https://twoplaidaprons.com/wp-content/uploads/2020/07/Korean-cream-cheese-garlic-bread-tearing-a-wedge-of-the-baked-garlic-bread.jpg", ingredients: "8 ounce cream cheese, softened", instructions: "In a large mixing bowl, whisk together all the ingredients for the garlic butter until completely smooth", saved: true)
    ]
    
    func storeRecipe(_ recipe: Recipe) {
        let encoder = PropertyListEncoder()
        // Convert the object to a Data object
        guard let encodedRecipe = try? encoder.encode(recipe) else {
            return
        }
        
        // Store the Data object in UserDefaults
        UserDefaults.standard.set(encodedRecipe, forKey: recipe.recipeName)
    }
    
    func retrieveRecipe(for recipeName: String) -> Recipe? {
        // Retrieve the Data object from UserDefaults
        guard let storedRecipe = UserDefaults.standard.data(forKey: recipeName) else {
            return nil
        }
        
        let decoder = PropertyListDecoder()
        // Convert the Data object back to the expected object type
        guard let decodedRecipe = try? decoder.decode(Recipe.self, from: storedRecipe) else {
            return nil
        }
        return decodedRecipe
    }
    
    func loadRecipes() -> [Recipe] {
//        self.recipes.append(contentsOf: recipes)
        return self.recipes
    }
    
    func add(recipe: Recipe) {
//        self.recipes.append(recipe)
        storeRecipe(recipe)
        self.recipes.append(recipe)
//        let decodedRecipe = retrieveRecipe(for: recipe.recipeName)
    }
    
    func addSaved(recipe: Recipe) {
//        storeRecipe(recipe)
        self.saved.append(recipe)
    }
    
    func removeSaved(recipe: Recipe) {
        self.saved = self.saved.filter { $0.recipeName != recipe.recipeName }
    }
    
    func loadSaved() {
        self.saved = self.recipes.filter({$0.saved == true})
    }
    
    func search(with query: String) {
        if query.isEmpty {
            self.filtered = self.recipes
        } else {
            self.filtered = self.recipes.filter({$0.recipeName.contains(query)})
            var recipeList: [String] = [String]()
            for recipe in filtered {
                recipeList.append(recipe.recipeName)
            }
            print(recipeList)
        }
    }
}
