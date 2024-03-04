//
//  EditTask.swift
//  SimpleTaskApp
//
//  Created by TD on 04.03.2024.
//

import SwiftUI

struct EditTask: View {
    var isNew = true
    @State private var title = ""
    @State private var description = ""
    @State private var inProgress = true
    let cdManager = CoreDateManager.shared
    @Environment(\.dismiss) var dismiss
    var task: Task?
    
    init(isNew: Bool, task: Task? = nil) {
        self.isNew = isNew
        self.task = task
        if let task = task {
            _title = State(initialValue: task.title ?? "")
            _description = State(initialValue: task.descriptionTask ?? "")
            _inProgress = State(initialValue: task.inProgress)
        }
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    TextField("Enter a name task", text: $title)
                        .textFieldStyle(.roundedBorder)
                    TextField("Enter a description task", text: $description)
                        .textFieldStyle(.roundedBorder)
                    if !isNew {
                        Divider()
                        Toggle("In progress", isOn: $inProgress)
                    }
                }
                .padding()
            }
            .navigationTitle(isNew ? "Add task" : "Save")
            .toolbar {
                ToolbarItem {
                    Button {
                        if isNew {
                            cdManager.saveNewTask(title: title, descriptionTask: description)
                        } else if let task = task {
                            cdManager.updateTask(task, title: title, descriptionTask: description, inProgress: inProgress)
                        }
                        dismiss()
                    } label: {
                        Text(isNew ? "Add task" : "Save")
                    }
                }
            }
            .overlay(alignment: .bottom) {
                Button {
                    if isNew {
                        cdManager.saveNewTask(title: title, descriptionTask: description)
                    } else if let task = task {
                        cdManager.updateTask(task, title: title, descriptionTask: description, inProgress: inProgress)
                    }
                    dismiss()
                } label: {
                    Text(isNew ? "Add Task" : "Save")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .font(.title3.weight(.bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding()
            }
        }
    }
}

#Preview {
    FinalView()
}
