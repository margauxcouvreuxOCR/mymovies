//
//  Movie.swift
//  MyMovies
//
//  Created by Margaux Mazaleyras on 22/11/2024.
//

import Foundation

struct Movie: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    private static var imagesURL = "https://image.tmdb.org/t/p/original"
    
    public var posterURL:String {
        guard let posterPath
        else {return "https://www.animalwebaction.com/media/cache/5e/49/5e49848f06e5cdca18fb0acbbcc79720.png"}
        let url = Movie.imagesURL + posterPath
        print(url)
        return url
    }
    
    
    static var mock: Movie {
        .init(adult: false, backdropPath: nil, genreIds: [], id: 1, originalLanguage: "en", originalTitle: "The Movie", overview: "A very great movie with a great story.", popularity: 0, posterPath: nil, releaseDate: "1999-01-06", title: "Le Movie", video: false, voteAverage: 0, voteCount: 0)
    }
    
}

struct MoviesResponse:Codable  {
    var results: [Movie]
    var page: Int
    var totalPages: Int
    var totalResults: Int
}
