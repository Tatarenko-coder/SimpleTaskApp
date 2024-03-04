//
//  TitleTask.swift
//  SimpleTaskApp
//
//  Created by TD on 04.03.2024.
//

import SwiftUI

struct TitleTask: View {
    @State private var status: Bool = false
    @ObservedObject var task: Task
    let cdManager = CoreDateManager.shared
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title ?? "")
                    .font(.headline)
                Text(task.inProgress ? "In progress" : "Completed")
                    .font(.footnote.weight(.regular))
                    .foregroundStyle(.secondary)
            }
            .padding(10)
        }
    }
}

#Preview {
    FinalView()
}
