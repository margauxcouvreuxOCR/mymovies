//
//  Movie.swift
//  MyMovies
//
//  Created by Margaux Mazaleyras on 22/11/2024.
//

import Foundation

struct Movie: Decodable {
    let adult: Bool
    let backdrop_path: String?
    let genre_ids: [Int]
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String?
    let release_date: Date
    let title: String
    let video: Bool
    let voteAverage: Double
    let vote_count: Int
    
    static var mock: Movie {
        .init(adult: false, backdrop_path: nil, genre_ids: [], id: 1, original_language: "en", original_title: "The Movie", overview: "A very great movie with a great story.", popularity: 0, poster_path: nil, release_date: .distantPast, title: "Le Movie", video: false, voteAverage: 0, vote_count: 0)
    }
    
}
