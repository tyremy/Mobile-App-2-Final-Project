//
//  ExerciseViewModel.swift
//  Tylers Training Tracker
//
//  Created by Tyler Remy on 4/7/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class ExerciseViewModel : ObservableObject {
    
    @Published var exercises = [ExerciseModel]()
    let db = Firestore.firestore()
    
    @MainActor
    func fetchData() async {
        self.exercises.removeAll()
        do {
          let querySnapshot = try await db.collection("Exercises").getDocuments()
          for document in querySnapshot.documents {
              do {
                  self.exercises.append(try document.data(as: ExerciseModel.self))
              } catch {
                  print(error)
              }
          }
        } catch {
          print("Error getting documents: \(error)")
        }
    }
    
    func saveData(exercise: ExerciseModel) {
        
        if let id = exercise.id {
            
            if !exercise.exerciseName.isEmpty || !exercise.exerciseType.isEmpty {
                
                let docRef = db.collection("Exercises").document(id)
                
                docRef.updateData([
                    "exerciseName": exercise.exerciseName,
                    "exerciseType": exercise.exerciseType,
                    "muscleGroup": exercise.muscleGroup
                ]) { err in
                    if let err = err{
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }
        } else {
            
            if !exercise.exerciseName.isEmpty || !exercise.exerciseType.isEmpty {
                var ref: DocumentReference? = nil
                ref = db.collection("Exercises").addDocument(data: [
                    "exerciseName": exercise.exerciseName,
                    "exerciseType": exercise.exerciseType,
                    "muscleGroup": exercise.muscleGroup
                ]) { err in
                    if let err = err{
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }
            }
        }
    }
    
}
