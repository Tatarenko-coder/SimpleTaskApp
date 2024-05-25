//
//  TasksView.swift
//  SimpleTaskApp
//
//  Created by TD on 04.03.2024.
//

import SwiftUI

struct TasksView: View {
    @State private var status: Bool = false
    @State private var statuses: [Bool] = Array(repeating: false, count: 5)
    @State private var addTask: Bool = false
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.inProgress, ascending: true)],
        animation: .default)
    private var tasks: FetchedResults<Task>
    let cdManager = CoreDateManager.shared
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { task in
                    NavigationLink {
                        DetaileTask(task: task)
                    } label: {
                        TitleTask(task: task)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        if task.inProgress {
                            Button {
                                cdManager.toggleToCompleted(task)
                            } label: {
                                Label("Toggle", systemImage: "checkmark.circle")
                            }
                            .tint(.green)
                        } else {
                            Button {
                                cdManager.deleteTask(task)
                            } label: {
                                Label("Toggle", systemImage: "trash")
                            }
                            .tint(.red)
                        }
                        
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("You Tasks")
            .toolbar {
                ToolbarItem {
                    Button {
                        addTask.toggle()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $addTask) {
                EditTask(isNew: true)
            }
        }
    }
}

#Preview {
    TasksView()
}
