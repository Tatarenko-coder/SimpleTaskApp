//
//  DetaileTask.swift
//  SimpleTaskApp
//
//  Created by TD on 04.03.2024.
//

import SwiftUI

struct DetaileTask: View {
    @State private var edit:Bool = false
    @State private var showAllertCompleted:Bool = false
    @ObservedObject var task: Task
    let cdManager = CoreDateManager.shared
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Status".uppercased())
                    .font(.footnote.weight(.regular))
                    .foregroundStyle(.secondary)
                Spacer()
                Text(task.inProgress ? "In Progress" : "Completed")
                    .font(.headline.weight(.regular))
                    .foregroundStyle(.primary)
            }
            Divider()
            Text("Motivation".uppercased())
                .font(.footnote.weight(.regular))
                .foregroundStyle(.secondary)
            Text(task.descriptionTask ?? "")
                .font(.headline.weight(.regular))
            Spacer()
            if task.inProgress {
                Button {
                    showAllertCompleted.toggle()
                } label: {
                    Text("Completed")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .font(.title3.weight(.bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
//                .alert("Do you want to complete this task?", isPresented: $showAllertCompleted) {
//                    Button("Yes", role: .destructive) {
//                        cdManager.toggleToCompleted(task)
//                    }
//                    Button("No", role: .cancel) { }
//                }
            }
            
        }
        .overlay(alignment: .center, content: {
            if showAllertCompleted {
                VStack(spacing: 20) {
                    Text("Do you want to complete this task?")
                        .multilineTextAlignment(.center)
                        .font(.headline)
                    HStack {
                        Button  {
                            showAllertCompleted = false
                        } label: {
                            Text("No")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundStyle(.blue)
                        }
                        Button  {
                            cdManager.toggleToCompleted(task)
                            showAllertCompleted = false
                        } label: {
                            Text("Yes")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundStyle(.green)
                            
                        }
                        
                    }
                    .padding(.horizontal)
                    
                }
                .padding()
                .frame(width: 220, height: 200, alignment: .center)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        })
        .padding(20)
        .navigationTitle(task.title ?? "")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    edit.toggle()
                } label: {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $edit) {
            EditTask(isNew: false, task: task)
        }
        
    }
}

#Preview {
    DetaileTask(task: Task(context: CoreDateManager.shared.content))
}




