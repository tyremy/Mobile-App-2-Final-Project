//
//  ExerciseDetail.swift
//  Tylers Training Tracker
//
//  Created by Tyler Remy on 4/7/24.
//

import SwiftUI

struct ExerciseDetail: View {
    
    @Binding var exercise : ExerciseModel
    @StateObject var exerciseApp = ExerciseViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Exercise Details")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding()
            TextField("Exercise Name", text: $exercise.exerciseName)
                .font(.system(size: 28))
                .padding()
                .multilineTextAlignment(.center)
            HStack{
                Text("Exercise Type:")
                    .foregroundColor(Color.gray)
                TextField("Exercise Type", text: $exercise.exerciseType)
                    .multilineTextAlignment(.trailing)
            }
                .font(.system(size: 20))
                .padding()
            HStack{
                Text("Muscle Group:")
                    .foregroundColor(Color.gray)
                TextField("Muscle Group", text: $exercise.muscleGroup)
                    .multilineTextAlignment(.trailing)
            }
            .padding()
                .font(.system(size: 20))
            Spacer()
        }
        .frame(alignment: .leading)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    exerciseApp.saveData(exercise: exercise)
                    exercise.exerciseName = ""
                    exercise.exerciseType = ""
                    exercise.muscleGroup = ""
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

#Preview {
    ExerciseDetail(exercise: .constant(ExerciseModel(exerciseName: "Bench Press", exerciseType: "Weight Training", muscleGroup: "Chest")))
}
