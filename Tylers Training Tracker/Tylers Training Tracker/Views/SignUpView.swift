//
//  SignUpView.swift
//  Tylers Training Tracker
//
//  Created by Tyler Remy on 4/10/24.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var authApp : AuthenticationViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var confirmpassword = ""
    @State private var name = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        
        VStack{
            Text("Welcome!")
                .padding(.bottom, 0)
                .font(.system(size: 24))
            Text("Please create your account")
                .padding(.top, 0)
                .font(.system(size: 20))
        }
        .padding()
        VStack {
            UserInputFieldView(input: $name, fieldTitle: "Name", fieldDefault: "Enter your name")
            UserInputFieldView(input: $email, fieldTitle: "Email", fieldDefault: "Enter your email")
            UserInputFieldView(input: $password, fieldTitle: "Password", fieldDefault: "Enter your password", isSecureField: true)
            UserInputFieldView(input: $confirmpassword, fieldTitle: "Confirm Password", fieldDefault: "Confirm your password", isSecureField: true)
        }
        .padding(.horizontal, 8)
        Button {
            Task {
                try await authApp.signUp(withEmail: email, password: password, name: name)
            }
        } label: {
            Text("Sign Up")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .disabled(!formValid)
        .padding(.horizontal, 100)
        .padding(.vertical, 10)
        .background(formValid ? Color.red : Color.gray)
        .border(Color.black)
        .cornerRadius(5)
        .padding(.top)
        
        Button {
            dismiss()
        } label: {
            Text("Returning User? Sign In")
        }
        .padding()
        
    }
}

extension SignUpView: AuthFormProtocol {
    var formValid: Bool {
         return !email.isEmpty &&
        !password.isEmpty &&
        !name.isEmpty &&
        password == confirmpassword
    }
    
}

#Preview {
    SignUpView()
}
