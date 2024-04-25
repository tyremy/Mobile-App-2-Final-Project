//
//  ExerciseSessionDetailView.swift
//  Tylers Training Tracker
//
//  Created by Tyler Remy on 4/22/24.
//

import SwiftUI

struct ExerciseSessionDetailView: View {
    
    @Binding var exerciseSession : ExerciseSessionModel
    @State var sessionLog = SessionLogModel(exerciseName: "", exerciseSets: 0, exerciseWeight: 0, exerciseReps: 0)
    @StateObject var exerciseSessionApp = ExerciseSessionViewModel()
    
    
    var body: some View {
        VStack {
            Text("Session Details")
                .font(.system(size: 22))
                .overlay(
                    Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.black),
                    alignment: .bottom
                    )
            HStack{
                Text("Session Name:")
                    .font(.system(size: 15))
                TextField("Session Name", text: $exerciseSession.sessionName)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
                    .padding(5)
                    .border(Color.gray, width: 2)
                    .cornerRadius(3)
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .padding(.top, 0)
            .padding(.bottom, 0)
            HStack{
                Text("Session Date:")
                Spacer()
                DatePicker(
                    "",
                    selection: $exerciseSession.date,
                    displayedComponents: [.date]
                )
            }
                .font(.system(size: 15))
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.top, 0)
                .padding(.bottom, 0)
            HStack{
                Text("Session Duration:")
                Spacer()
                TextField("Session Duration", value: $exerciseSession.duration, formatter: NumberFormatter())
                    .frame(width: 40)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
                    .padding(4)
                    .border(Color.gray, width: 2)
                    .cornerRadius(3)
            }
                .font(.system(size: 15))
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.top, 0)
                .padding(.bottom, 0)
            
            List {
                ForEach(exerciseSessionApp.sessionLog) { sessionLog in
                    
                    Section{
                        VStack{
                            HStack{
                                Text("Exercise Name:")
                                    .fontWeight(.bold)
                                Text(sessionLog.exerciseName)
                            }
                            Divider()
                            HStack{
                                Text("Reps:")
                                Text("\(sessionLog.exerciseReps)")
                            }
                            HStack{
                                Text("Reps:")
                                Text("\(sessionLog.exerciseReps)")
                            }
                            HStack{
                                Text("Reps:")
                                Text("\(sessionLog.exerciseReps)")
                            }
                        }
                    }
                }
                
                Section {
                    NavigationLink {
                        EditSessionDetailsView(exerciseSession: $exerciseSession, sessionLog: $sessionLog)
                    } label: {
                        Text("Add New Exercise To Session")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 15))
                    }
                }
            }
            .task {
                await exerciseSessionApp.fetchSessionInfo(selectedSession: $exerciseSession.id!)
            }
            .listStyle(.insetGrouped)
        }
        .background(Color.red)
        //.frame(alignment: .leading)
        .padding(.top, 0)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    exerciseSessionApp.saveData(exerciseSession: exerciseSession)
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

