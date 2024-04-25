//
//  ExerciseSessionViewModel.swift
//  Tylers Training Tracker
//
//  Created by Tyler Remy on 4/22/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ExerciseSessionViewModel : ObservableObject {
    
    @Published var exerciseSession = [ExerciseSessionModel]()
    @Published var sessionLog = [SessionLogModel]()
    let db = Firestore.firestore()
    
    @MainActor
    func fetchData() async {
        
        
        self.exerciseSession.removeAll()
        do {

            guard let userID = Auth.auth().currentUser?.uid else {
                    return
            }
            
          let querySnapshot = try await db.collection("Users/\(userID)/Exercise_History").getDocuments()
          for document in querySnapshot.documents {
              do {
                  self.exerciseSession.append(try document.data(as: ExerciseSessionModel.self))
              } catch {
                  print(error)
              }
          }
        } catch {
          print("Error getting documents: \(error)")
        }
    }
    
    @MainActor
    func fetchSessionInfo(selectedSession: String) async {
        
        
        self.sessionLog.removeAll()
        do {
            
            guard let userID = Auth.auth().currentUser?.uid else {
                return
            }
            
                let querySnapshot = try await db.collection("Users/\(userID)/Exercise_History/\(selectedSession)/Session Log").getDocuments()
                for document in querySnapshot.documents {
                    do {
                        self.sessionLog.append(try document.data(as: SessionLogModel.self))
                    } catch {
                        print(error)
                    }
                }
            } catch {
                print("Error getting documents: \(error)")
            }
        }
    
    func saveData(exerciseSession: ExerciseSessionModel) {
    
        
        if let id = exerciseSession.id {
            
            if !exerciseSession.sessionName.isEmpty {
                
                guard let userID = Auth.auth().currentUser?.uid else {
                    return
                }
                
                let docRef = db.collection("Users/\(userID)/Exercise_History").document(id)
                
                docRef.updateData([
                    "sessionName": exerciseSession.sessionName,
                    "date": exerciseSession.date,
                    "duration": exerciseSession.duration
                ]) { err in
                    if let err = err{
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }
        } else {
            
            if !exerciseSession.sessionName.isEmpty  {
                
                guard let userID = Auth.auth().currentUser?.uid else {
                    return
                }
                
                var ref: DocumentReference? = nil
                ref = db.collection("Users/\(userID)/Exercise_History").addDocument(data: [
                    "sessionName": exerciseSession.sessionName,
                    "date": exerciseSession.date,
                    "duration": exerciseSession.duration
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
    
    @MainActor
    func saveSession(exerciseSession: ExerciseSessionModel, sessionLog: SessionLogModel)  {
        
        
        if let id = exerciseSession.id {
            
            
            guard let userID = Auth.auth().currentUser?.uid else {
                return
            }
    
            var ref: DocumentReference? = nil
            ref = db.collection("Users/\(userID)/Exercise_History/\(id)/Session Log").addDocument(data: [
                "exerciseName": sessionLog.exerciseName,
                "exerciseSets": sessionLog.exerciseSets,
                "exerciseReps": sessionLog.exerciseReps,
                "exerciseWeight": sessionLog.exerciseWeight
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

protocol SessionFormProtocol {
    var sessionValid : Bool { get }
}
