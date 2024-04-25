//
//  ExerciseModel.swift
//  Tylers Training Tracker
//
//  Created by Tyler Remy on 4/7/24.
//

import Foundation
import FirebaseFirestoreSwift

struct ExerciseModel : Codable, Identifiable {
    
    @DocumentID var id: String?
    var exerciseName: String
    var exerciseType: String
    var muscleGroup: String
    
}
