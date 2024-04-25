//
//  UserIntegerInputFieldView.swift
//  Tylers Training Tracker
//
//  Created by Tyler Remy on 4/24/24.
//

import SwiftUI

struct UserIntegerInputFieldView: View {
    
    @Binding var input : Int
    let fieldTitle: String
    let fieldDefault: String
    
    var body: some View {
        VStack (alignment: .leading){
            Text(fieldTitle)
                .fontWeight(.bold)
                .padding(.bottom, 0)
            TextField(fieldDefault, value: $input, formatter: NumberFormatter())
                .padding(.top, 0)
                .autocapitalization(.none)
        }
        .padding(5)
    }
}

#Preview {
    UserInputFieldView(input: .constant(""), fieldTitle: "Weight", fieldDefault: "Name")
}
