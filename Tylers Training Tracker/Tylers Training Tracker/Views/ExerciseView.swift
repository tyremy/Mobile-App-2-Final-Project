//
//  ContentView.swift
//  Tylers Training Tracker
//
//  Created by Tyler Remy on 4/7/24.
//

import SwiftUI

struct ExerciseView: View {
    
    @StateObject var exerciseApp = ExerciseViewModel()
    @State var exercise = ExerciseModel(exerciseName: "", exerciseType: "", muscleGroup: "")
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($exerciseApp.exercises) { $exercise in
                    NavigationLink {
                        ExerciseDetail(exercise: $exercise)
                    } label : {
                        Text(exercise.exerciseName)
                    }
                }
                
                Section {
                    NavigationLink {
                        ExerciseDetail(exercise: $exercise)
                    } label: {
                        Text("Add New Exercise")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 15))
                    }
                }
            }
            .task {
               await exerciseApp.fetchData()
            }
            .navigationBarTitle("Select an Exercise")
        }
    }
}

#Preview {
    ExerciseView()
}
