//
//  WorkoutHistoryView.swift
//  Tylers Training Tracker
//
//  Created by Tyler Remy on 4/10/24.
//

import SwiftUI

struct EditSessionDetailsView: View {
    
    @Binding var exerciseSession : ExerciseSessionModel
    @Binding var sessionLog : SessionLogModel
    @StateObject var exerciseSessionApp = ExerciseSessionViewModel()
    
    var body: some View {
        VStack {
            List {
                Section {
                    Text("Edit Session Details:")
                        .multilineTextAlignment(.center)
                }
                .font(.system(size: 22))
                VStack (alignment: .leading){
                    
                    Text("Exercise Name")
                        .fontWeight(.bold)
                        .padding(.bottom, 0)
                    TextField("Enter exercise name", text: $sessionLog.exerciseName)
                        .padding(.top, 0)
                        .autocapitalization(.none)
                }
                .padding(5)
                UserIntegerInputFieldView(input: $sessionLog.exerciseSets, fieldTitle: "Sets", fieldDefault: "Enter Sets")
                UserIntegerInputFieldView(input: $sessionLog.exerciseReps, fieldTitle: "Reps", fieldDefault: "Enter Reps")
                UserIntegerInputFieldView(input: $sessionLog.exerciseWeight, fieldTitle: "Weight", fieldDefault: "Enter Weight")
            }
            .listStyle(.insetGrouped)
            
            
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                         exerciseSessionApp.saveSession(exerciseSession: exerciseSession, sessionLog: sessionLog)
                    }
                } label: {
                    Text("Save")
                }
            }
        }
    }
}
