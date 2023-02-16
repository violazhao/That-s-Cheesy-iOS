//
//  UserManager.swift
//  That's Cheesy
//
//  Created by Viola Zhao on 2/14/23.
//

import Foundation
import UIKit

class UserManager {
    static let shared: UserManager = UserManager()
    var user = User(username: "Jerry", password: "Cheesy123")
}
