//
//  ExerciseHistoryModel.swift
//  Tylers Training Tracker
//
//  Created by Tyler Remy on 4/22/24.
//

import Foundation
import FirebaseFirestoreSwift

struct ExerciseSessionModel : Codable, Identifiable {
    
    @DocumentID var id: String?
    var sessionName: String
    var date: Date
    var duration: Int
    
}
