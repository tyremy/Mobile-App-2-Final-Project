//
//  ExerciseSessionsView.swift
//  Tylers Training Tracker
//
//  Created by Tyler Remy on 4/22/24.
//

import SwiftUI

struct ExerciseSessionView: View {
    
    @StateObject var exerciseSessionApp = ExerciseSessionViewModel()
    @State var exerciseSession = ExerciseSessionModel(sessionName: "", date: Date(), duration: 0)
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($exerciseSessionApp.exerciseSession) { $exerciseSession in
                    NavigationLink {
                        ExerciseSessionDetailView(exerciseSession: $exerciseSession)
                    } label : {
                        Text(exerciseSession.sessionName)
                    }
                }
                
                Section {
                    NavigationLink {
                        NewWorkoutView()
                    } label: {
                        Text("Add New Session")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 15))
                    }
                }
                
            }
            .task {
               await exerciseSessionApp.fetchData()
            }
            .navigationBarTitle("Select a Session")
        }.accentColor(.black)
    }
}

#Preview {
    ExerciseSessionView()
}
