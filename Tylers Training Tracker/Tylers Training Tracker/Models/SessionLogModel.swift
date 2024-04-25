//
//  SessionLogModel.swift
//  Tylers Training Tracker
//
//  Created by Tyler Remy on 4/23/24.
//

import Foundation
import FirebaseFirestoreSwift

struct SessionLogModel : Codable, Identifiable {
    
    @DocumentID var id: String?
    var exerciseName: String
    var exerciseSets: Int
    var exerciseWeight: Int
    var exerciseReps: Int
    
}
