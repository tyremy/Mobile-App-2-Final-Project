//
//  LoginView.swift
//  Tylers Training Tracker
//
//  Created by Tyler Remy on 4/10/24.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authApp : AuthenticationViewModel
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                
                
                VStack{
                    Text("Welcome!")
                        .padding(.bottom, 0)
                        .font(.system(size: 24))
                    Text("Please Login")
                        .padding(.top, 0)
                        .font(.system(size: 20))
                }
                .padding()
                VStack {
                    UserInputFieldView(input: $email, fieldTitle: "Email", fieldDefault: "Enter your email")
                    UserInputFieldView(input: $password, fieldTitle: "Password", fieldDefault: "Enter your password", isSecureField: true)
                }
                .padding(.horizontal, 8)
                Button {
                    Task { try await authApp.signIn(withEmail: email, password: password)
                    }
                } label: {
                    Text("Sign In")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 100)
                .padding(.vertical, 10)
                .background(Color.red)
                .border(Color.black)
                .cornerRadius(5)
                .padding(.top)
                .alert(isPresented: $authApp.showErr, content: {
                                Alert(title: Text(authApp.errorMessage))
                            })
                
                NavigationLink {
                    SignUpView()
                } label: {
                    Text("New User? Sign Up Here")
                }
                .padding()
                
            }
        }
    }
}
