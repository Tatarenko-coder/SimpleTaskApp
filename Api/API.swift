//
//  API.swift
//  SimpleTaskApp
//
//  Created by TD on 04.03.2024.
//

import SwiftUI


struct API: View {
    @StateObject var newsService = NewsService.shared
    @State var news: [Article] = []
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMesege = ""
    var body: some View {
        NavigationView {
            if isLoading {
                ProgressView("Loading...")
            } else {
                List {
                    ForEach(Array(news.enumerated()), id: \.offset) { index, article in
                        VStack(alignment: .leading) {
                            Text(article.title)
                                .font(.title3).fontWeight(.semibold)
                            Text(article.description ?? "")
                                .font(.callout).fontWeight(.regular)
                            HStack {
                                Spacer()
                                Text("by:")
                                    .font(.footnote).fontWeight(.light)
                                    .foregroundStyle(.secondary)
                                Text(article.author ?? "")
                                    .font(.footnote).fontWeight(.light)
                            }
                        }
                    }
                }
                .navigationTitle("News")
            }
        }
        .onAppear {
            isLoading = true
            newsService.fetchNews { result in
                isLoading = false
                switch result {
                case .success(let success):
                    news = success
                case .failure(let networkError):
                    errorMesege = warningMessage(error: networkError)
                    showError = true
                }
            }
        }
        .alert(isPresented: $showError) {
            Alert(title: Text(errorMesege))
        }
    }
}

#Preview {
    API()
}
