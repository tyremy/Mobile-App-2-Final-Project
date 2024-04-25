//
//  NewWorkoutView.swift
//  Tylers Training Tracker
//
//  Created by Tyler Remy on 4/10/24.
//

import SwiftUI

struct NewWorkoutView: View {
    
    @EnvironmentObject var authApp : ExerciseSessionViewModel
    @State private var sessionDuration = 0
    @State private var sessionDate = Date()
    @State private var sessionName = ""
    @State private var exerciseCounter = 1
    @StateObject var exerciseSessionApp = ExerciseSessionViewModel()
    @State var exerciseSession = ExerciseSessionModel(sessionName: "", date: Date(), duration: 0)
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack{
            Text("Tyler's Training Tracker")
                .padding(.vertical, 15)
                .frame(width: UIScreen.main.bounds.width)
                .background(Color.red)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 28))
            Text("Create New Exercise Session")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .padding()
            UserInputFieldView(input: $sessionName, fieldTitle: "Session Name", fieldDefault: "Enter session name")
            HStack{
                Text("Session Date:")
                Spacer()
                DatePicker(
                        "",
                        selection: $sessionDate,
                        displayedComponents: [.date]
                )
            }
            .fontWeight(.bold)
            .padding(5)
            .border(Color.gray)
            HStack{
                Text("Session Duration:")
                Spacer()
                TextField("Session Duration", value: $sessionDuration, formatter: NumberFormatter())
                    .multilineTextAlignment(.trailing)
            }
            .fontWeight(.bold)
            .padding(8)
            .border(Color.gray)
            
            Button {
                Task {
                    exerciseSessionApp.saveData(exerciseSession: ExerciseSessionModel(sessionName: sessionName, date: sessionDate, duration: sessionDuration))
                    exerciseSession.sessionName = ""
                    exerciseSession.duration = 0
                    
                }
            } label: {
                Text("Create New Session")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 10)
            .disabled(!sessionValid)
            .background(sessionValid ? Color.red : Color.gray)
            .border(Color.black)
            .cornerRadius(5)
            .padding(.top)
            
            Button {
                dismiss()
            } label: {
                Text("Back to Sessions")
            }
            .foregroundColor(.blue)
            
        }
        .padding(.leading, 5)
        .padding(.trailing, 5)
        Spacer()
    }
}

extension NewWorkoutView: SessionFormProtocol {
    var sessionValid: Bool {
        return !sessionName.isEmpty
    }
}


#Preview {
    NewWorkoutView()
}
