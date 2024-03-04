//
//  FinalView.swift
//  SimpleTaskApp
//
//  Created by TD on 04.03.2024.
//

import SwiftUI

struct FinalView: View {
    var body: some View {
        TabView {
            TasksView()
                .tabItem {
                    Label("Tasks", systemImage: "checklist")
                }
            API()
                .tabItem {
                    Label("API Relise", systemImage: "newspaper")
                }
        }
    }
}

#Preview {
    FinalView()
}

