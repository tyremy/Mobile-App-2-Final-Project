//
//  UserModel.swift
//  Tylers Training Tracker
//
//  Created by Tyler Remy on 4/10/24.
//

import Foundation

struct UserModel : Identifiable, Codable {
    
    var id : String
    var email: String
    var name : String
    
}
