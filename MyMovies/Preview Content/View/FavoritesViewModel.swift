//
//  FavoritesViewModel.swift
//  MyMovies
//
//  Created by Margaux Mazaleyras on 25/11/2024.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var favoriteMovies: [Movie] = []

    func add(_ movie: Movie) {
        if !favoriteMovies.contains(where: { $0.id == movie.id }) {
            favoriteMovies.append(movie)
        }
    }

    func remove(_ movie: Movie) {
        favoriteMovies.removeAll { $0.id == movie.id }
    }

    func isFavorite(_ movie: Movie) -> Bool {
        if favoriteMovies.isEmpty {
            return false
        }
        return favoriteMovies.contains(where: { $0.id == movie.id })
    }
}
