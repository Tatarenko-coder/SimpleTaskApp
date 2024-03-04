//
//  APIManage.swift
//  SimpleTaskApp
//
//  Created by TD on 04.03.2024.
//

import Foundation


enum Link {
    case news
    
    var url: URL? {
        switch self {
        case .news:
            return URL(string: "​https://newsapi.org/v2/everything?q=tesla&from=2024-02-04&sortBy=publishedAt&apiKey=3b995d6c8e0b4abfb0561b09fe654077")
        }
    }
}

enum NetworkError: Error {
    case notData, toManyRequest, decodingError
}

func warningMessage(error: NetworkError) -> String {
    switch error {
    case .notData:
        return "Data cannot be found at this URL"
    case .toManyRequest:
        return "Sorry!429: Too many requests"
    case .decodingError:
        return "Sorry! Can't decode data"
    }
}

final class NewsService: ObservableObject {
    
    init() {}
    
    static let shared = NewsService()
    
    private let apiKey = "3b995d6c8e0b4abfb0561b09fe654077"
    private let baseURL = "https://newsapi.org/v2/everything?q=tesla&from=2024-02-04&sortBy=publishedAt&apiKey="
    
    func fetchNews(completion: @escaping (Result<[Article], NetworkError>) -> Void) {
        print("fetch")
        let fetchRequest = URLRequest(url: (Link.news.url ?? URL(string: baseURL + apiKey))!)
        URLSession.shared.dataTask(with: fetchRequest) { (data, response, error) -> Void in
            if error != nil {
                print( "Error in session is not nil")
                completion(.failure(.notData))
            } else {
                let httpResponse  = response as? HTTPURLResponse
                print("status code: \(String(describing: httpResponse?.statusCode))")
                
                if httpResponse?.statusCode == 429 {
                    
                    completion(.failure(.toManyRequest))
                    
                } else {
                    
                    guard let safeData = data else { return }
                    
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let newsResponse = try decoder.decode(NewsResponse.self, from: safeData)
                        completion(.success(newsResponse.articles))
                    } catch let decodeError {
                        print("Decoding error: \(decodeError.localizedDescription)")
                        print("Decoding error: \(String(describing: error))")
                        completion(.failure(.decodingError))
                    }
                }
                
            }
        }.resume()
        
    }
}
