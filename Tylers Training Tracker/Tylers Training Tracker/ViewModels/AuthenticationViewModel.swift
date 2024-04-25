//
//  AuthenticationViewModel.swift
//  Tylers Training Tracker
//
//  Created by Tyler Remy on 4/10/24.
//

import Foundation
import Firebase
import FirebaseAuth

@MainActor
class AuthenticationViewModel : ObservableObject {
    
    @Published var userSession : FirebaseAuth.User?
    @Published var currentUser : UserModel?
    let db = Firestore.firestore()
    @Published var showErr = false
    var errorMessage = ""
    
    init() {
        
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchData()
        }
        
    }
    
    func signUp(withEmail email: String, password: String, name: String) async throws {
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await db.collection("Users").document(result.user.uid).setData([
                "email": email,
                "name": name,
                "id": result.user.uid
            ])
            await fetchData()
        } catch {
            print("Error creating user: \(error)")
        }
        
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchData()
        } catch {
            showError(message: "Incorrect Username or Password")
        }
        
    }
    
    func signOut() {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            self.currentUser = nil
            self.userSession = nil
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
    }
    
    func fetchData() async {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let docRef = db.collection("Users").document(uid)
            
            do {
                let document = try await docRef.getDocument()
                if document.exists {
                    currentUser = try document.data(as: UserModel.self)
                } else {
                    print("User does not exist")
                }
            } catch {
                print("Error getting User: \(error)")
            }
        
    }
    
    func showError(message: String) {
        errorMessage = message
        showErr = true
    }
    
}

protocol AuthFormProtocol {
    var formValid : Bool { get }
}
