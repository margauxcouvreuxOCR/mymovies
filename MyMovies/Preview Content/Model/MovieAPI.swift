//
//  MovieAPI.swift
//  MyMovies
//
//  Created by Margaux Mazaleyras on 22/11/2024.
//

import Foundation

class MovieAPI {
    
    static let shared = MovieAPI()
    
    func fetchMovies(query: String) async -> [Movie] {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(query)&include_adult=false&language=en-US&page=1") else {
            print("Invalid URL")
            return []
        }
        
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let movieData = try decoder.decode([Movie].self, from: data) // Décoder en tableau
           return movieData
        } catch {
            print(error.localizedDescription)
            return[]
        }
    }
}
