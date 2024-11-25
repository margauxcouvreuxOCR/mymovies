//
//  ViewModel.swift
//  MyMovies
//
//  Created by Margaux Mazaleyras on 25/11/2024.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var movies: [Movie] = []

    func fetchMovies(query: String) {
        Task {
            self.movies = await MovieAPI.shared.fetchMovies(query: query)
        }
    }
}
