//
//  NetworkManager.swift
//  TheGaming_Library
//
//  Created by Joseph Bouhanef on 2022-09-08.
//

import UIKit

class NetworkManager {
    static let shared   = NetworkManager()
    private let baseURL = "https://api.rawg.io/api/games"

    private let apiKey = "c6d03fa5674a46af93019dc936e1f2f9"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
     
//https://api.rawg.io/api/games?key=c6d03fa5674a46af93019dc936e1f2f9&page=6&search=batman
    func getGames(for username: String, page: Int, completed: @escaping (Result<SearchResults, GFError>) -> Void) {
        
        let endpoint = baseURL + "?key=\(apiKey)&page=\(page)&search=\(username)"
        print("endpoint: \(endpoint)")
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let games = try decoder.decode(SearchResults.self, from: data)
               
            
                completed(.success(games))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getGameInfo(for id: Int,  completed: @escaping (Result<Game, GFError>) -> Void) {

        let endpoint = baseURL + "/\(id)?key=\(apiKey)"
   print("endpoint: \(endpoint)")
        print(type(of: endpoint))
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let game = try decoder.decode(Game.self, from: data)
                completed(.success(game))
            } catch {
                completed(.failure(.invalidData))
            }
        }

        task.resume()
    }

}

